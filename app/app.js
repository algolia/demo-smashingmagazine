let Search = {
  init() {
    this.search = instantsearch({
      appId: 'MXM0JWJNIW',
      apiKey: '9c62478734752cda73afc3db232e47de',
      indexName: 'smashingmagazine'
    });

    this.addSearchBoxWidget();
    this.addStatsWidget();
    this.addTagsWidget();
    this.addSortByWidget();
    this.addHitsWidget();
    this.addPaginationWidget();

    this.search.start();

    // $('#searching_2').focus();
  },
  getHighlightedValue(object, property) {
    if (!_.has(object, `_highlightResult.${property}.value`)) {
      console.info(object, property);
      return object[property];
    }
    return object._highlightResult[property].value;
  },
  transformItem(input) {
    let data = {
      url: input.url,
      image: input.image
    };

    // Add the number of comments
    if (input.commentCount > 1) {
      data.comments = `${input.commentCount} Comments`;
    } else {
      data.comments = input.commentCout === 0 ? null : '1 Comment';
    }

    // Display date in human readable form
    data.date = moment.unix(input.publishedDate).format('MMMM Do, YYYY');


    // Pass highlighted versions
    data.title = Search.getHighlightedValue(input, 'title');
    data.author = Search.getHighlightedValue(input, 'author');
    data.description = Search.getHighlightedValue(input, 'description');

    // TODO: Highlight tags
    data.tags = input.tags;


    // Keep a json version of the data, for easy debugging
    data._initialData = JSON.stringify(input, null, 2);

    return data;
  },
  addSearchBoxWidget() {
    this.search.addWidget(
      instantsearch.widgets.searchBox({
        container: '#searching_2',
        placeholder: 'Search in all Smashing posts',
        wrapInput: false
      })
    );
  },
  addStatsWidget() {
    this.search.addWidget(
      instantsearch.widgets.stats({
        container: '#search-stats',
        cssClasses: {
          root: 'search-stats'
        }
      })
    );
  },
  addTagsWidget() {
    this.search.addWidget(
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
  },
  addSortByWidget() {
    this.search.addWidget(
      instantsearch.widgets.sortBySelector({
        container: '#search-sort-by',
        indices: [
          {name: 'smashingmagazine', label: 'Most relevant'},
          {name: 'smashingmagazine_comment_count_desc', label: 'Most commented'},
          {name: 'smashingmagazine_published_date_desc', label: 'Latest published'}
        ]
      })
    );
  },
  addHitsWidget() {
    let hitTemplate = document.getElementById('templateSearch-hit').innerHTML;
    let emptyTemplate = 'No results';
    this.search.addWidget(
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
          item: Search.transformItem
        }
      })
    );
  },
  addPaginationWidget() {
    this.search.addWidget(
      instantsearch.widgets.pagination({
        container: '#search-pagination',
        cssClasses: {
          root: 'search-pagination'
        }
      })
    );
  }
};

export default Search;
