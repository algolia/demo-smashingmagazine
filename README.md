# smashingmagazine

## Dependencies

You'll need the
[sitemap-downloader](https://github.com/algolia/algolia-sitemap-downloader)

## Get sitemaps

Download sitemaps file with

```
$ sitemap-downloader http://http://www.smashingmagazine.com/ \
http://www.smashingmagazine.com/post-sitemap1.xml \
http://www.smashingmagazine.com/post-sitemap2.xml \
http://www.smashingmagazine.com/post-sitemap3.xml \
http://www.smashingmagazine.com/page-sitemap.xml \
http://www.smashingmagazine.com/category-sitemap.xml
```

## Get JSON

Download html post pages and extract JSON with

```
bundle exec ruby ./post_downloader ./sitemaps/post-sitemap1.xml
bundle exec ruby ./post_downloader ./sitemaps/post-sitemap2.xml
bundle exec ruby ./post_downloader ./sitemaps/post-sitemap3.xml
```



