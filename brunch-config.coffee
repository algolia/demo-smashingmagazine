module.exports = config:
  files:
    javascripts: joinTo: 'app.js'
    stylesheets: joinTo: 'search.css'
  plugins:
    sass:
      mode: 'native'
    babel:
      presets: ['es2015']
      ignore: []
      pattern: /\.(js)$/
  server:
      run: yes
      port: 5005

