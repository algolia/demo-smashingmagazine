module.exports = {
  paths: {
    watched: ['app/assets', 'app/styles/', 'app/javascripts/']
  },
  files: {
    javascripts: {
      joinTo: {
        'index.js': /^app\/javascripts\/index.js/,
        'step1.js': /^app\/javascripts\/step1.js/,
        'step2.js': /^app\/javascripts\/step2.js/,
        'step3.js': /^app\/javascripts\/step3.js/,
        'step4.js': /^app\/javascripts\/step4.js/
      }
    },
    stylesheets: {
      joinTo: {
        'index.css': /^app\/styles\/index.scss/,
        'step1.css': /^app\/styles\/step1.scss/,
        'step2.css': /^app\/styles\/step2.scss/,
        'step3.css': /^app\/styles\/step3.scss/,
        'step4.css': /^app\/styles\/step4.scss/
      }
    }
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
