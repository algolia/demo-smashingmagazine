(function() {
  'use strict';

  var globals = typeof window === 'undefined' ? global : window;
  if (typeof globals.require === 'function') return;

  var modules = {};
  var cache = {};
  var aliases = {};
  var has = ({}).hasOwnProperty;

  var endsWith = function(str, suffix) {
    return str.indexOf(suffix, str.length - suffix.length) !== -1;
  };

  var _cmp = 'components/';
  var unalias = function(alias, loaderPath) {
    var start = 0;
    if (loaderPath) {
      if (loaderPath.indexOf(_cmp) === 0) {
        start = _cmp.length;
      }
      if (loaderPath.indexOf('/', start) > 0) {
        loaderPath = loaderPath.substring(start, loaderPath.indexOf('/', start));
      }
    }
    var result = aliases[alias + '/index.js'] || aliases[loaderPath + '/deps/' + alias + '/index.js'];
    if (result) {
      return _cmp + result.substring(0, result.length - '.js'.length);
    }
    return alias;
  };

  var _reg = /^\.\.?(\/|$)/;
  var expand = function(root, name) {
    var results = [], part;
    var parts = (_reg.test(name) ? root + '/' + name : name).split('/');
    for (var i = 0, length = parts.length; i < length; i++) {
      part = parts[i];
      if (part === '..') {
        results.pop();
      } else if (part !== '.' && part !== '') {
        results.push(part);
      }
    }
    return results.join('/');
  };

  var dirname = function(path) {
    return path.split('/').slice(0, -1).join('/');
  };

  var localRequire = function(path) {
    return function expanded(name) {
      var absolute = expand(dirname(path), name);
      return globals.require(absolute, path);
    };
  };

  var initModule = function(name, definition) {
    var module = {id: name, exports: {}};
    cache[name] = module;
    definition(module.exports, localRequire(name), module);
    return module.exports;
  };

  var require = function(name, loaderPath) {
    var path = expand(name, '.');
    if (loaderPath == null) loaderPath = '/';
    path = unalias(name, loaderPath);

    if (has.call(cache, path)) return cache[path].exports;
    if (has.call(modules, path)) return initModule(path, modules[path]);

    var dirIndex = expand(path, './index');
    if (has.call(cache, dirIndex)) return cache[dirIndex].exports;
    if (has.call(modules, dirIndex)) return initModule(dirIndex, modules[dirIndex]);

    throw new Error('Cannot find module "' + name + '" from '+ '"' + loaderPath + '"');
  };

  require.alias = function(from, to) {
    aliases[to] = from;
  };

  require.register = require.define = function(bundle, fn) {
    if (typeof bundle === 'object') {
      for (var key in bundle) {
        if (has.call(bundle, key)) {
          modules[key] = bundle[key];
        }
      }
    } else {
      modules[bundle] = fn;
    }
  };

  require.list = function() {
    var result = [];
    for (var item in modules) {
      if (has.call(modules, item)) {
        result.push(item);
      }
    }
    return result;
  };

  require.brunch = true;
  require._cache = cache;
  globals.require = require;
})();
require.register("app", function(exports, require, module) {
'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});
var Search = {
  init: function init() {
    this.search = instantsearch({
      appId: 'MXM0JWJNIW',
      apiKey: '9c62478734752cda73afc3db232e47de',
      indexName: 'smashingmagazine'
    });
    console.info('iuiu');

    this.addSearchBoxWidget();
    // this.addStatsWidget();
    // this.addClearAllWidget();
    // this.addBookWidget();
    // this.addChapterWidget();
    // this.addHitsWidget();
    // this.addPaginationWidget();

    this.search.start();

    $('#searching_2').focus();
  },
  addSearchBoxWidget: function addSearchBoxWidget() {
    this.search.addWidget(instantsearch.widgets.searchBox({
      container: '#searching_2',
      placeholder: 'Search in all Smashing posts'
    }));
  }
};
// search.addWidget(
//   instantsearch.widgets.searchBox({
//     container: '#searching_2',
//     wrapInput: false
//   })
// );
//
// search.addWidget(
//   instantsearch.widgets.sortBySelector({
//     container: '#search-sort-by',
//     indices: [
//       {name: 'smashingmagazine_posts', label: 'Most relevant'},
//       {name: 'smashingmagazine_posts_published_date_desc', label: 'Published date'},
//       {name: 'smashingmagazine_posts_comment_count_desc', label: 'Number of comments'}
//     ]
//   })
// );
//
// search.addWidget(
//   instantsearch.widgets.hits({
//     container: '#search-hits',
//     cssClasses: {
//       root: 'search-hits'
//     },
//     templates: {
//       empty: 'No results',
//       item: document.getElementById('template-search-hits').innerHTML
//     },
//     transformData: {
//       item: function(data) {
//         // Add the number of comments
//         if (data.comment_count > 1) {
//           data.comments = data.comment_count + ' Comments';
//         } else {
//           data.comments = data.comment_cout === 0 ? null : '1 Comment';
//         }
//
//         // Display date in human readable form
//         data.date = moment.unix(data.published_date).format('MMMM Do, YYYY');
//
//         // Pass highlighted versions
//         data.title = data._highlightResult.title ? data._highlightResult.title.value : data.title;
//         data.description = data._highlightResult.description ? data._highlightResult.description.value : data.description;
//         data.author = data._highlightResult.author ? data._highlightResult.author.value : data.author;
//         if (data._highlightResult.tags) {
//           data.tags = data._highlightResult.tags.map(function(tag) {
//             return tag.value;
//           });
//         }
//         // Keep a json version of the data, for easy debugging
//         data._initialData = JSON.stringify(data, null, 2);
//         return data;
//       }
//     }
//   })
// );
//
// // TODO: https://github.com/algolia/instantsearch.js/issues/668
// search.addWidget(
//   instantsearch.widgets.pagination({
//     container: '#search-pagination',
//     cssClasses: {
//       root: 'search-pagination'
//     }
//   })
// );
//
// search.addWidget(
//   instantsearch.widgets.stats({
//     container: '#search-stats',
//     cssClasses: {
//       root: 'search-stats'
//     }
//   })
// );
//
// search.addWidget(
//   instantsearch.widgets.refinementList({
//     container: '#search-tags',
//     attributeName: 'tags',
//     operator: 'and',
//     limit: 10,
//     cssClasses: {
//       root: 'search-tags',
//       header: 'search-tags-header'
//     },
//     templates: {
//       header: 'Tags'
//     }
//   })
// );
exports.default = Search;
});


//# sourceMappingURL=search.js.map