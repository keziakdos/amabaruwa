/// <reference path="../pb_data/types.d.ts" />

migrate((app) => {
  const collection = new Collection({
    type: "base",
    name: "lettres",
    listRule: "statut = \"publie\"",
    viewRule: "statut = \"publie\"",
    createRule: null,
    updateRule: null,
    deleteRule: null,
    fields: [
      {
        type: "number",
        name: "numero",
        required: true,
        min: 1,
        onlyInt: true,
      },
      {
        type: "text",
        name: "slug",
        required: true,
        min: 1,
        max: 200,
        pattern: "^[a-z0-9]+(?:-[a-z0-9]+)*$",
      },
      {
        type: "text",
        name: "langue",
        required: true,
        min: 2,
        max: 8,
      },
      {
        type: "text",
        name: "titre",
        required: true,
        min: 1,
        max: 500,
      },
      {
        type: "text",
        name: "contenu_html",
        required: false,
        max: 0,
      },
      {
        type: "select",
        name: "statut",
        required: true,
        maxSelect: 1,
        values: ["brouillon", "publie"],
      },
      {
        type: "file",
        name: "pdf_file",
        required: false,
        maxSelect: 1,
        maxSize: 52428800,
        mimeTypes: ["application/pdf"],
        protected: true,
        thumbs: [],
      },
      {
        type: "file",
        name: "audio_file",
        required: false,
        maxSelect: 1,
        maxSize: 104857600,
        mimeTypes: ["audio/mpeg"],
        protected: true,
        thumbs: [],
      },
      {
        type: "url",
        name: "url_origine",
        required: false,
      },
      {
        type: "text",
        name: "source_key",
        required: true,
        min: 1,
        max: 255,
      },
      {
        type: "date",
        name: "source_modified_at",
        required: false,
      },
      {
        type: "number",
        name: "pdf_size_bytes",
        required: false,
        min: 0,
        onlyInt: true,
      },
      {
        type: "number",
        name: "audio_size_bytes",
        required: false,
        min: 0,
        onlyInt: true,
      },
      {
        type: "text",
        name: "pdf_sha256",
        required: false,
        min: 0,
        max: 64,
        pattern: "^[a-f0-9]{64}$",
      },
      {
        type: "text",
        name: "audio_sha256",
        required: false,
        min: 0,
        max: 64,
        pattern: "^[a-f0-9]{64}$",
      },
      {
        type: "number",
        name: "audio_duration_seconds",
        required: false,
        min: 0,
      },
      {
        type: "autodate",
        name: "created",
        onCreate: true,
        onUpdate: false,
      },
      {
        type: "autodate",
        name: "updated",
        onCreate: true,
        onUpdate: true,
      },
    ],
    indexes: [
      "CREATE UNIQUE INDEX idx_lettres_source_key ON lettres (source_key)",
      "CREATE UNIQUE INDEX idx_lettres_numero_langue ON lettres (numero, langue)",
      "CREATE INDEX idx_lettres_statut ON lettres (statut)",
      "CREATE INDEX idx_lettres_slug ON lettres (slug)",
    ],
  })

  app.save(collection)
}, (app) => {
  const collection = app.findCollectionByNameOrId("lettres")
  app.delete(collection)
})
