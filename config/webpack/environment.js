const { environment } = require('@rails/webpacker')

const webpack = require('webpack')


//Nos deja usar estos pligins de forma global
environment.plugins.prepend('Provide',
  new webpack.ProvidePlugin({
  $: 'jquery',
  jQuery: 'jquery',
  'windows.jQuery': 'jquery',
  Popper: ['popper.js', 'default']
  })
)

module.exports = environment
