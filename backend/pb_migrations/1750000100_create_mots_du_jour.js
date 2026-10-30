/// <reference path="../pb_data/types.d.ts" />

migrate((app) => {
  const lettres = app.findCollectionByNameOrId("lettres")

  const collection = new Collection({
    type: "base",
    name: "mots_du_jour",
    listRule: "statut = \"publie\" && (lettre_liee = \"\" || lettre_liee.statut = \"publie\")",
    viewRule: "statut = \"publie\" && (lettre_liee = \"\" || lettre_liee.statut = \"publie\")",
    createRule: null,
    updateRule: null,
    deleteRule: null,
    fields: [
      {
        type: "text",
        name: "date_locale",
        required: true,
        min: 10,
        max: 10,
        pattern: "^[0-9]{4}-[0-9]{2}-[0-9]{2}$",
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
        name: "citation",
        required: true,
        min: 1,
        max: 0,
      },
      {
        type: "text",
        name: "reference_source",
        required: true,
        min: 1,
        max: 500,
      },
      {
        type: "relation",
        name: "lettre_liee",
        required: false,
        collectionId: lettres.id,
        maxSelect: 1,
        cascadeDelete: false,
      },
      {
        type: "file",
        name: "audio_extrait",
        required: false,
        maxSelect: 1,
        maxSize: 104857600,
        mimeTypes: ["audio/mpeg"],
        protected: true,
        thumbs: [],
      },
      {
        type: "select",
        name: "statut",
        required: true,
        maxSelect: 1,
        values: ["brouillon", "publie"],
      },
      {
        type: "text",
        name: "source_key",
        required: true,
        min: 1,
        max: 255,
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
      "CREATE UNIQUE INDEX idx_mots_source_key ON mots_du_jour (source_key)",
      "CREATE UNIQUE INDEX idx_mots_date_langue ON mots_du_jour (date_locale, langue)",
      "CREATE INDEX idx_mots_statut ON mots_du_jour (statut)",
      "CREATE INDEX idx_mots_lettre_liee ON mots_du_jour (lettre_liee)",
    ],
  })

  app.save(collection)
}, (app) => {
  const collection = app.findCollectionByNameOrId("mots_du_jour")
  app.delete(collection)
})
