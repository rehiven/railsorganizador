const { environment } = require('@rails/webpacker')

const Webpack = require('webpack')

environment.plugins.prepend('Provide,
new webpack.Provide.Plugin({
  $: 'jquery',
  jQuery: 'jquery',
  'windows.jQuery': 'jquery',
  Popper: ['popper.js', 'default']
})
)

module.exports = environment
