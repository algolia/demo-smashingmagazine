module.exports = {
  paths: {
    watched: ['app/assets', 'app/styles/', 'app/javascripts/']
  },
  files: {
    javascripts: {
      joinTo: {
        'initial.js': /^app\/javascripts\/initial\//,
        'step1.js': /^app\/javascripts\/step1\//,
        'step2.js': /^app\/javascripts\/step2\//,
        'step3.js': /^app\/javascripts\/step3\//,
        'step4.js': /^app\/javascripts\/step4\//,
        'step5.js': /^app\/javascripts\/step5\//,
      }
    },
    stylesheets: {joinTo: 'search.css'}
  },
  plugins: {
    sass: {
      mode: 'native'
    },
    babel: {
      presets: ['es2015'],
      ignore: [],
      pattern: /\.js$/
    }
  },
  server: {
    run: 'yes',
    port: 5005
  }
};
