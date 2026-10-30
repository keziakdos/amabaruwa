/// <reference path="../pb_data/types.d.ts" />

migrate((app) => {
  const settings = app.settings()

  settings.meta.appName = "Amabaruwa"
  settings.meta.appURL = "https://amabaruwa.rwazap.com"

  settings.logs.maxDays = 14
  settings.logs.logAuthId = true
  settings.logs.logIP = false

  settings.trustedProxy.headers = ["X-Forwarded-For", "X-Real-IP"]
  settings.trustedProxy.useLeftmostIp = true

  app.save(settings)
}, (app) => {
  const settings = app.settings()
  settings.meta.appName = "Acme"
  settings.meta.appURL = ""
  settings.logs.maxDays = 5
  settings.logs.logAuthId = false
  settings.logs.logIP = true
  settings.trustedProxy.headers = []
  settings.trustedProxy.useLeftmostIp = false
  app.save(settings)
})
