import 'dart:async';
import 'dart:io';

import 'package:audio_session/audio_session.dart';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

import '../../core/database/app_database.dart';
import '../../features/letters/models/letter.dart';

class AudioService extends ChangeNotifier {
  AudioService(this._db) {
    _positionSub = _player.positionStream.listen((value) {
      _position = value;
      _maybeNotify();
    });
    _stateSub = _player.playerStateStream.listen((value) {
      _playing = value.playing;
      if (value.processingState == ProcessingState.completed) {
        _playing = false;
        _savePosition(force: true);
      }
      notifyListeners();
    });
    _errorSub = _player.errorStream.listen((error) {
      _error = 'Guhagarika amajwi byanze.';
      _playing = false;
      notifyListeners();
    });
    _initSession();
    _saveTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (_playing) {
        _savePosition();
      }
    });
  }

  final AppDatabase _db;
  final AudioPlayer _player = AudioPlayer();

  StreamSubscription<Duration>? _positionSub;
  StreamSubscription<PlayerState>? _stateSub;
  StreamSubscription<Object>? _errorSub;
  StreamSubscription<AudioInterruptionEvent>? _interruptionSub;
  StreamSubscription<void>? _noisySub;
  Timer? _saveTimer;
  Timer? _sleepTimer;

  Letter? _current;
  String? _localPath;
  String? _error;
  bool _playing = false;
  bool _initialized = false;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  double _speed = 1;
  DateTime? _sleepEndsAt;
  DateTime _lastNotify = DateTime.fromMillisecondsSinceEpoch(0);

  Letter? get current => _current;
  String? get localPath => _localPath;
  String? get error => _error;
  bool get playing => _playing;
  Duration get position => _position;
  Duration get duration => _duration;
  bool get hasSource => _current != null;
  double get speed => _speed;
  DateTime? get sleepEndsAt => _sleepEndsAt;
  AudioPlayer get player => _player;

  Future<void> _initSession() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.music());
    _interruptionSub = session.interruptionEventStream.listen((event) async {
      if (event.begin) {
        if (_playing) {
          await _player.pause();
        }
      }
    });
    _noisySub = session.becomingNoisyEventStream.listen((_) async {
      if (_playing) {
        await _player.pause();
      }
    });
  }

  Future<void> playLetter(
    Letter letter, {
    String? localPath,
    double? initialPosition,
  }) async {
    _error = null;
    final same = _current?.id == letter.id && _localPath == localPath;
    if (same && _initialized) {
      if (_playing) {
        await pause();
      } else {
        await resume();
      }
      return;
    }

    await _player.stop();
    _current = letter;
    _localPath = localPath;
    _initialized = false;
    _position = Duration.zero;
    _duration = Duration.zero;
    _sleepEndsAt = null;
    _sleepTimer?.cancel();
    notifyListeners();

    final tag = MediaItem(
      id: letter.id,
      title: letter.titre,
      album: 'Amabaruwa',
      displayTitle: letter.titre,
    );

    AudioSource? source;
    if (localPath != null && localPath.isNotEmpty) {
      final file = File(localPath);
      if (await file.exists()) {
        final expected = letter.audioSizeBytes;
        final length = await file.length();
        if (expected == null || expected == length) {
          source = AudioSource.file(localPath, tag: tag);
        }
      }
    }
    source ??= letter.hasAudio
        ? AudioSource.uri(Uri.parse(letter.audioUrl!), tag: tag)
        : null;

    if (source == null) {
      _error = 'Nta majwi abonetse kuri iyi baruwa.';
      notifyListeners();
      return;
    }

    try {
      await _player.setAudioSource(source);
      _duration = _player.duration ?? Duration.zero;
      final start = initialPosition ?? letter.audioPositionSeconds;
      if (start > 0) {
        final target = Duration(milliseconds: (start * 1000).round());
        if (_duration == Duration.zero || target < _duration) {
          await _player.seek(target);
        }
      }
      _initialized = true;
      await _player.setSpeed(_speed);
      await _player.play();
    } catch (_) {
      _error = 'Gukurura amajwi byanze. Ongera ugerageze.';
      _playing = false;
      notifyListeners();
    }
  }

  Future<void> resume() async {
    if (!_initialized) {
      return;
    }
    _error = null;
    await _player.play();
  }

  Future<void> pause() async {
    await _player.pause();
    await _savePosition(force: true);
  }

  Future<void> toggle() async {
    if (_playing) {
      await pause();
    } else {
      await resume();
    }
  }

  Future<void> seek(Duration position) async {
    if (!_initialized) {
      return;
    }
    await _player.seek(position);
    _position = position;
    notifyListeners();
  }

  Future<void> skip(Duration delta) async {
    if (!_initialized) {
      return;
    }
    final max = _player.duration ?? _duration;
    var target = _player.position + delta;
    if (target < Duration.zero) {
      target = Duration.zero;
    }
    if (max > Duration.zero && target > max) {
      target = max;
    }
    await seek(target);
  }

  Future<void> setSpeed(double value) async {
    _speed = value;
    await _player.setSpeed(value);
    notifyListeners();
  }

  void setSleepTimer(Duration? duration) {
    _sleepTimer?.cancel();
    if (duration == null) {
      _sleepEndsAt = null;
      notifyListeners();
      return;
    }
    _sleepEndsAt = DateTime.now().add(duration);
    _sleepTimer = Timer(duration, () async {
      await pause();
      _sleepEndsAt = null;
      notifyListeners();
    });
    notifyListeners();
  }

  Future<void> _savePosition({bool force = false}) async {
    final letter = _current;
    if (letter == null) {
      return;
    }
    if (!force && _position == Duration.zero) {
      return;
    }
    await _db.saveAudioPosition(letter.id, _position.inMilliseconds / 1000);
  }

  void _maybeNotify() {
    final now = DateTime.now();
    if (now.difference(_lastNotify).inMilliseconds < 250) {
      return;
    }
    _lastNotify = now;
    if (_duration == Duration.zero) {
      _duration = _player.duration ?? Duration.zero;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _positionSub?.cancel();
    _stateSub?.cancel();
    _errorSub?.cancel();
    _interruptionSub?.cancel();
    _noisySub?.cancel();
    _saveTimer?.cancel();
    _sleepTimer?.cancel();
    unawaited(_savePosition(force: true));
    _player.dispose();
    super.dispose();
  }
}
