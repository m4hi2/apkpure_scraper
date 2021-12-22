# ApkpureScraper

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `apkpure_scraper` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:apkpure_scraper, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/apkpure_scraper>.

Notes:

The website doesn't allow robots with unknown origin. So, have to use the following user agent:
`Mozilla/5.0 (Linux; Android 5.0; SM-G920A) AppleWebKit (KHTML, like Gecko) Chrome Mobile Safari (compatible; AdsBot-Google-Mobile; +http://www.google.com/mobile/adsbot.html)`
This basically tricks the site into thinking this is a google bot.
Even though google says this bot can't be spoofed because of IP verification, the site
doesn't seem to check the IPs.
