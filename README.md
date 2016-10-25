# InstantSearch SmashingMagazine

This repo holds an alternate version of the search page of the SmashingMagazine
website, using the Algolia instantsearch.js library.

![Screencast][1]

It also contains all the necessary code to run it on your own and see how its
internales. You can see a live demo on
[https://algolia.github.io/demo-smashingmagazine/](https://algolia.github.io/demo-smashingmagazine/)

## Running the local version

To run the example locally, install the dependencies and run the server:

```
npm install
npm run serve
```

It will start the local server on http://localhost:5005/. Note that this local
version will target one of our pre-populated indices. If you want to push data
to your own server, keep reading.

## Using your own Algolia account

The `./data/records.json` file holds a copy of all the records (used with
SmashingMagazine permission). The data is from a snapshot of all the articles
the website from October 2016.

We've already pre-populated an index with this data so you can test it live, but
if you'd rather use your own index on your Algolia account, we're also providing
scripts to help you with that.

You first need to create a file named `_algolia_api_key` at the root of the
project. This file should contain your Admin API key (you can find it in your
Algolia dashboard). This key is more powerful than the Search API key as it can
add, edit and delete records. You should keep this key private and not share it.
This is why we put it in an external file, not tracked by Git.

### Pushing data

The `push` script located in the `./scripts` directory will push the content of
the `./data/records.json` file to your Algolia index. You need to edit the
script to replace the `XXXXXX` with your real `APPID`.

The script is pushing 500 records at a time using the `add_objects` method.
This is the preferred way when pushing a lot of records (instead of pushing them
one by one).

### Configuring the index

Once your data is pushed, you can access it through your Algolia Dashboard and
tweak the settings. Every setting you can change through the dashboard can also
be modified through the API.

The `set_settings` script in the `./scripts` directory will push a set of
settings to your index. The settings we set are the one we found yielding the
most relevant results. Feel free to tweak it to see what impact each setting has
on the relevance.

As for pushing the data, don't forget to change the `XXXXXX` with your real
`APPID`.

## Step by step building

We did a 15mn livecoding of this demo, so if you'd like to follow the
incremental steps, you can find them here as well:


### Step 1: Basic search

[https://community.algolia.com/demo-smashingmagazine/step1.html]()

In this first version we removed the previous search results and replaced them
with an HTML placeholder. We included and instanciated instantsearch.js and
added two basic widgets. The first one will listen to keystrokes on the
searchbar and send requests to the Algolia API. The second one will listen to
responses from the API and display the results.

This is the most basic setup to have an InstantSearch page working. As you can
see, the results are not styled and data is displayed raw.


### Step 2: Styling

[https://community.algolia.com/demo-smashingmagazine/step2.html]()

In this step, we improved the template used to render the results (we call them
`hits`). We have a more complex HTML structure with title, image, author, tags
and description. We also added styling through CSS so the results are now more
readable.

Still, we can do better. Results have no highlighting of the search terms and
some data (like the published date) are displayed in a raw format.

### Step 3: Enhancing results

[https://community.algolia.com/demo-smashingmagazine/step3.html]()

This time, we'll work a bit on enhancing the way results are displayed. We are
using highlighted version of the title, author and description. We also make use
of the `transformData` function in instantsearch.js to replace raw values with
more readable versions.

### Step 4: Enhancing the page

[https://community.algolia.com/demo-smashingmagazine/step4.html]()

We're almost done. We'll now add more widgets to enhance the experience.
Results can now be paginated, you can have some stats about the speed of the
queries and you can filter results through tags.

### Step 5: Final version

[https://community.algolia.com/demo-smashingmagazine/]()

On this final version we've reworked a bit on the JavaScript code to make it
more readable, and we added a sort option to order results by number of comments
or date.


[1]: ./docs/screencast.gif
