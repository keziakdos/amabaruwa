/// <reference path="../pb_data/types.d.ts" />

migrate((app) => {
  const lettres = app.findCollectionByNameOrId("lettres")
  const contenu = lettres.fields.find((field) => field.name === "contenu_html")
  if (!contenu) {
    throw new Error("Champ contenu_html introuvable")
  }
  contenu.max = 200000
  app.save(lettres)

  const mots = app.findCollectionByNameOrId("mots_du_jour")
  const citation = mots.fields.find((field) => field.name === "citation")
  if (!citation) {
    throw new Error("Champ citation introuvable")
  }
  citation.max = 20000
  app.save(mots)
}, (app) => {
  const lettres = app.findCollectionByNameOrId("lettres")
  const contenu = lettres.fields.find((field) => field.name === "contenu_html")
  if (contenu) {
    contenu.max = 0
    app.save(lettres)
  }

  const mots = app.findCollectionByNameOrId("mots_du_jour")
  const citation = mots.fields.find((field) => field.name === "citation")
  if (citation) {
    citation.max = 0
    app.save(mots)
  }
})
