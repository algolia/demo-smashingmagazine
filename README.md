# Demo SmashingMagazine

This is a demo of including Algolia InstantSearch to SmashingMagazine. The
repository holds three parts:

- A working local demo
- The scripts to download and extract the records
- The records themselves

## Local demo

TODO

## Dev

All the script tooling is expected to be run with npm scripts (ie. `npm run`).
Start by installing all the needed dependency with `npm install`. It will
automatically install the Bundle dependencies as well.

### Download sitemaps

First, download the sitemaps using `npm run download_sitemaps`. It will download
all sitemaps in `./data/sitemaps` in XML format.

The list of sitemaps is hardcoded. Just check if
[http://www.smashingmagazine.com/post-sitemap4.xml](http://www.smashingmagazine.com/post-sitemap4.xml)
is available and add it to the list if it is.

### Download HTML files

`npm run download` will download all the HTML pages into `./data/html`. If
a file is already downloaded, it will just be skipped.

### Extract records from HTML files

Run `npm run extract` to extract the records from the HTML files. Records will
be saved in `./data/records`. Previous records will be overriden. The content of
each `json` file is pretty printed, with keys sorted, so diffs are easier to
read.

You can configure `./scripts/extract` to define the CSS selectors that grabs the
various parts of the record. Just add a new method prefixed with `record_`
inside `SmashingSelector` and the result will be outputted in the `json` file.

You can also define the `filename(data)` method to specify the filename under
which the record will be saved in `./data/records`. I currently use the
`objectID`.

Finally, you can prevent some records from being saved by defining the
`save_record?(data, file)` method. It will get both the record data as well as
the original HTML filepath and you can return `false` to not save this record.

### Push records to the Algolia index

`npm run push` will push all the records to Algolia. The `appId`, `indexName` as
well as all settings can be configured in `./scripts/push`. The `apiKey` should
either be set as the `ALGOLIA_API_KEY` environment variable, or written in
a `./_algolia_api_key` file.

### Tests

You can run tests with `npm run test` and run a watched version (great for TDD)
with `npm run test:watch`. The tests are few, and only cover the extraction
part, not the front-end.

