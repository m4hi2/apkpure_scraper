# ApkpureScraper

Collecting all available app data from Apkpure. 


Notes:

The website doesn't allow robots with unknown origin. So, have to use the following user agent:
`Mozilla/5.0 (Linux; Android 5.0; SM-G920A) AppleWebKit (KHTML, like Gecko) Chrome Mobile Safari (compatible; AdsBot-Google-Mobile; +http://www.google.com/mobile/adsbot.html)`
This basically tricks the site into thinking this is a google bot.
Even though google says this bot can't be spoofed because of IP verification, the site
doesn't seem to check the IPs.

Filtering Sitemap urls `Enum.filter(fn {"loc", _, [url]} -> !String.contains?(url, ["group", "default", "tag", "topics"]) end)`

Required Fields:

- App name
- Developer Name
- Category
- Version
- App Description
- Play Store Link
- Images
- App icon
