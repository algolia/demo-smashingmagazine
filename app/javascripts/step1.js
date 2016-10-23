let Search = {
  init() {

    let search = instantsearch({
      appId: 'KHKP14DMQR',
      apiKey: '2ad9f79596007d25d292ba994f0554f7',
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
