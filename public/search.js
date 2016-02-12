/* global instantsearch */

var search = instantsearch({
  appId: 'MXM0JWJNIW',
  apiKey: '9c62478734752cda73afc3db232e47de',
  indexName: 'smashingmagazine_posts',
  urlSync: true
});

search.addWidget(
  instantsearch.widgets.searchBox({
    container: '#searching_2',
    wrapInput: false
  })
);

search.addWidget(
  instantsearch.widgets.sortBySelector({
    container: '#search-sort-by',
    indices: [
      {name: 'smashingmagazine_posts', label: 'Most relevant'},
      {name: 'smashingmagazine_posts_published_date_desc', label: 'Published date'},
      {name: 'smashingmagazine_posts_comment_count_desc', label: 'Number of comments'}
    ]
  })
);

search.addWidget(
  instantsearch.widgets.hits({
    container: '#search-hits',
    cssClasses: {
      root: 'search-hits'
    },
    templates: {
      empty: 'No results',
      item: document.getElementById('template-search-hits').innerHTML
    },
    transformData: {
      item: function(data) {
        // Add the number of comments
        if (data.comment_count > 1) {
          data.comments = data.comment_count + ' Comments';
        } else {
          data.comments = data.comment_cout === 0 ? null : '1 Comment';
        }

        // Display date in human readable form
        data.date = moment.unix(data.published_date).format('MMMM Do, YYYY');

        // Pass highlighted versions
        data.title = data._highlightResult.title ? data._highlightResult.title.value : data.title;
        data.description = data._highlightResult.description ? data._highlightResult.description.value : data.description;
        data.author = data._highlightResult.author ? data._highlightResult.author.value : data.author;
        if (data._highlightResult.tags) {
          data.tags = data._highlightResult.tags.map(function(tag) {
            return tag.value;
          });
        }
        // Keep a json version of the data, for easy debugging
        data._initialData = JSON.stringify(data, null, 2);
        return data;
      }
    }
  })
);

// TODO: https://github.com/algolia/instantsearch.js/issues/668
search.addWidget(
  instantsearch.widgets.pagination({
    container: '#search-pagination',
    cssClasses: {
      root: 'search-pagination'
    }
  })
);

search.addWidget(
  instantsearch.widgets.stats({
    container: '#search-stats',
    cssClasses: {
      root: 'search-stats'
    }
  })
);

search.addWidget(
  instantsearch.widgets.refinementList({
    container: '#search-tags',
    attributeName: 'tags',
    operator: 'and',
    limit: 10,
    cssClasses: {
      root: 'search-tags',
      header: 'search-tags-header'
    },
    templates: {
      header: 'Tags'
    }
  })
);

search.start();
