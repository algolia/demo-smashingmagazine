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
        templates: {
          empty: emptyTemplate,
          item: hitTemplate
        }
      })
    );

    search.start();
  }
};

export default Search;
