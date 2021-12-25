import Config

config :crawly,
  closespider_timeout: 10,
  middlewares: [
    {Crawly.Middlewares.UserAgent, user_agents: ["Mozilla/5.0 (Linux; Android 5.0; SM-G920A) AppleWebKit (KHTML, like Gecko) Chrome Mobile Safari (compatible; AdsBot-Google-Mobile; +http://www.google.com/mobile/adsbot.html)"]}
  ],
  pipelines: [
    {ApkpureScraper.PrintPipeline},
    Crawly.Pipelines.JSONEncoder,
    {Crawly.Pipelines.WriteToFile, extension: "jl", folder: "/tmp", include_timestamp: true}
  ]
