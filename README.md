# Demo SmashingMagazine

This is a demo of including Algolia InstantSearch to SmashingMagazine. The
repository holds three parts:

- A working local demo
- The scripts to download and extract the records
- The records themselves

## Local demo

TODO

## Dev

If you want to run the crawler again, first start with `./scripts/install`.

### Download sitemaps

First, download the sitemaps again using `./scripts/download_sitemaps`. It will download
all sitemaps in `./data/sitemaps` in XML format.

The list of sitemaps is hardcoded. Just check if
[http://www.smashingmagazine.com/post-sitemap4.xml](http://www.smashingmagazine.com/post-sitemap4.xml)
is available and add it to the list if it is.

### Download HTML files

Then, run `./scripts/download`. This will download all the HTML pages into
`./data/html`. If a file is already downloaded, it will just be skipped.

### Extract records from HTML files

Run `./scripts/extract` to extract the records from the HTML files. Records will
be saved in `./data/records`. Previous records will be overriden. The content of
each `json` file is pretty printed, with keys sorted, so diffs are easier to
read.

You can configure `./scripts/extract` to define the CSS selectors that grabs the
various parts of the record. Just add a new method prefixed with `record_`
inside `SmashingSelector` and the result will be outputted in the `json` file.

You can also define the `filename(data)` method to specify the filename under which
the record will be saved in `./data/records`. I currently use the `objectID`.

Finally, you can prevent some records from being saved by defining the
`save_record?(data, file)` method. It will get both the record data as well as
the original HTML filepath and you can return `false` to not save this record.

