# Livecode SmashingMagazine

This repo holds the code to livecode the migration from Google Search to Algolia
InstantSearch on the SmashingMagazine website.

Start with an `npm install` to get all the dependencies.

## Pushing data

You can push data to the index using `npm run push` (or `./scripts/push`).

You can update the index settings by using `npm run set_settings` (or
`./scripts/set_settings`).

Don't forget to create a file named `_algolia_api_key` at the root of the repo
and that contains your Write API key.

## Serving

Run `npm run serve` (or `./scripts/serve`) to serve the website. You can then
access the steps:

### Step 1: Basic search

http://localhost:5005/step1.html

- We included instantsearch.js from the CDN. 
- No specific styling
- We init InstantSearch to the search bar
- Simple results are displayed (image and name)

### Step 2: Styling

- We updated the template for a better HTML
- Adding styling through CSS
- Still raw date and comment count

### Step 3: Enhancing results

- Adding a transformData (display correct number of comments and date)
- Adding highlight

### Step 4: Enhancing the page

- Stats
- Pagination
- Facets

