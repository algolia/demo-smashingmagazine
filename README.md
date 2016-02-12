# smashingmagazine

## Dev

If you want to run the crawler again, here are the steps:

### Download sitemaps

First, download the sitemaps again using `./scripts/download_sitemaps`. It will download
all sitemaps in `./sitemaps` in XML format.

The list of sitemaps is hardcoded. Just check if
[http://www.smashingmagazine.com/post-sitemap4.xml](http://www.smashingmagazine.com/post-sitemap4.xml)
is available and add it to the list if it is.

## Get JSON

Download html post pages and extract JSON with

```
bundle exec ruby ./post_downloader ./sitemaps/post-sitemap1.xml
bundle exec ruby ./post_downloader ./sitemaps/post-sitemap2.xml
bundle exec ruby ./post_downloader ./sitemaps/post-sitemap3.xml
```


[1]: https://github.com/algolia/algolia-sitemap-downloader
