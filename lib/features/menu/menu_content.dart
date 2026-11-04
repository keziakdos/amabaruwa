class InfoSection {
  const InfoSection({this.heading, required this.text});

  final String? heading;
  final String text;
}

class InfoPage {
  const InfoPage({
    required this.slug,
    required this.title,
    required this.url,
    required this.sections,
    this.contactEmail,
  });

  final String slug;
  final String title;
  final String url;
  final List<InfoSection> sections;
  final String? contactEmail;

  static const nyirikwandika = InfoPage(
    slug: 'nyirikwandika',
    title: 'Nyirikwandika',
    url: 'https://www.inzirayakristu.com/nyirikwandika/',
    sections: [
      InfoSection(
        heading: 'Aya Mabaruwa n’Inyandiko ni igikorwa cya Kristu',
        text:
            'Aya Mabaruwa n’Inyandiko ni igikorwa cya Kristu. Yagaragaje '
            'neza ko bigomba gutangwa ku buntu kuri murandasi. Ndi '
            '“Nyirikwandika” gusa.',
      ),
      InfoSection(
        text:
            'Amabaruwa yakiriwe mu wa 2000 na 2001. Yashyizwe ku rubuga rwa '
            'murandasi guhera muri 2001. Iya mbere mu Nyandiko, aho Kristu '
            'avuga ku buzima bwacu bwa buri munsi, yakiriwe muri 2003, naho '
            'mu butumwa bwe, ubuheruka bwatanganjwe mu Kuboza 2014.',
      ),
      InfoSection(
        text:
            'Muri izi nyandiko, nta kintu na kimwe cyakuwe mu zindi '
            'nyandiko, nubwo abandi banditsi na bo bahumekewemo na Kristu. '
            'Abantu bose bahuje n’Ibonunumva rye basenderejwe umugisha.',
      ),
      InfoSection(
        text:
            'Hashize imyaka 50 inzira yanjye yo kuba “nyirikwandika wa '
            'Kristu” itangiye, ubwo narengwagaho n’ingorane. Nagarukiye '
            'Kristu na Bibiliya kugira ngo mbone ubufasha. Imiterere ihana '
            'y’igisubizo yatumye mpagarika ihame ryose ry’idini maze '
            'mpinduka umuhakanyi. Mu myaka ibiri nasenze mbikuye ku mutima '
            'kugira ngo nerekwe Ukuri n’imiterere nyayo y’Igitera byose '
            'kubaho, amaherezo nza kwerekwa ko Imana ari Urukundo. Uko '
            'nagiye nkurikiza amabwiriza ya Kristu, nerekejwe mu nzira '
            'nshya. Hakurikiraho imyaka irindwi y’amahirwe, yaje na yo '
            'gukurikirwa n’ibintu byinshi bibabaza.',
      ),
      InfoSection(
        text:
            'Umugoroba umwe, ndimo nsenga, Kristu anyigaragariza '
            'bitunguranye. Yambwiye icyo ngiye kwigishwa n’icyo nagombaga '
            'gukora amaherezo. Kuva muri 1963 kugeza muri 1978, Kristu '
            'yanyigishije amahame asobanura mu Mabaruwa ye. Muri 1975, '
            'naraye ijoro nerekwa ibintu byagombaga kubaho hagati ya 1983 '
            'na 1994. Byose byarabaye koko.',
      ),
      InfoSection(
        text:
            'Mu wa 2000, Kristu yatangiye kunyandikisha Amabaruwa, hataho '
            'Inyandiko n’ubundi butumwa.',
      ),
    ],
  );

  static const beneBudama = InfoPage(
    slug: 'bene-budama',
    title: 'Bene BUDAMA',
    url: 'https://www.inzirayakristu.com/bene-budama/',
    sections: [
      InfoSection(
        heading: 'BUDAMA',
        text: 'Bene BUzima DAta MAma = BeneBUDAMA',
      ),
      InfoSection(
        heading:
            'Mu Mabaruwa ye, Kristu yita Imana Buzima Data Mama Ni ho '
            'havuye iriya mpine: BUDAMA',
        text:
            'Twebwe abasomye aya Mabaruwa akatugirira akamaro gakomeye mu '
            'gutuma turushaho kubona no kumva neza Imana, abantu, '
            'n’ubuzima muri rusange, twifuje kuyageza ku bavuga '
            'ikinyarwanda. Mu kwishyira hamwe ngo dukore uwo murimo, '
            'twahisemo kwiyita “Bene BUDAMA”.',
      ),
      InfoSection(
        text:
            'Ariko byumvikane ko, kuri twe, umuntu wese iyo ava akagera ari '
            '“Mwene BUDAMA”. Si twe twanditse aya Mabaruwa, icyo twakoze ni '
            'ukuyahindura tuyakura mu rurimi rwayo rw’umwimerere '
            '(icyongereza) tuyazana mu rurimi rw’ikinyarwanda. Turifuza ko '
            'Abanyarwanda benshi bayasoma kuko twizeye ko azabagirira '
            'akamaro nk’ako yatugiriye, bakarushaho kubaho mu byishimo no '
            'kubana mu mahoro.',
      ),
    ],
  );

  static const kudutumaho = InfoPage(
    slug: 'kudutumaho',
    title: 'Kudutumaho',
    url: 'https://www.inzirayakristu.com/kudutumaho/',
    contactEmail: 'contact@inzirayakristu.com',
    sections: [
      InfoSection(
        text: 'Ushobora kutwandikira, Cyangwa ugasiga Ubutumwa uciye hano:',
      ),
    ],
  );

  static const all = [nyirikwandika, beneBudama, kudutumaho];

  static InfoPage? bySlug(String slug) {
    for (final page in all) {
      if (page.slug == slug) {
        return page;
      }
    }
    return null;
  }
}
