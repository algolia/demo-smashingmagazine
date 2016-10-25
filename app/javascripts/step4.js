let Search = {
  init() {

    let search = instantsearch({
      appId: 'latency',
      apiKey: 'c80a1f43b1650d1a2225d95d6df0ffab',
      indexName: 'smashingmagazine'
    });

    // Search bar
    search.addWidget(
      instantsearch.widgets.searchBox({
        container: '#searchbar',
        placeholder: 'Search in all Smashing posts',
        wrapInput: false
      })
    );

    let hitTemplate = document.getElementById('templateSearch-hit').innerHTML;
    let emptyTemplate = 'No results';
    search.addWidget(
      instantsearch.widgets.hits({
        container: '#search-hits',
        hitsPerPage: 20,
        cssClasses: {
          root: 'search-hits'
        },
        templates: {
          empty: emptyTemplate,
          item: hitTemplate
        },
        transformData: {
          item: (data) => {
            // Date in human-readable format
            data.date = moment.unix(data.publishedDate).format('MMMM Do, YYYY');

            // Number of comments
            if (data.commentCount > 1) {
              data.comments = `${data.commentCount} Comments`;
            } else {
              data.comments = data.commentCout === 0 ? null : '1 Comment';
            }

            return data;
          }
        }
      })
    );

    // Add stats
    search.addWidget(
      instantsearch.widgets.stats({
        container: '#search-stats',
        cssClasses: {
          root: 'search-stats'
        }
      })
    );

    // Pagination
    search.addWidget(
      instantsearch.widgets.pagination({
        container: '#search-pagination',
        scrollTo: false,
        cssClasses: {
          root: 'search-pagination'
        }
      })
    );

    // Tag cloud
    search.addWidget(
      instantsearch.widgets.refinementList({
        container: '#search-tags',
        attributeName: 'tags.name',
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
  }
};

export default Search;

