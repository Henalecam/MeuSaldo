const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*',
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
      'colors':{
        'log-in-primary': '#9CC7FF',
        'log-in-secondary': '#D9D9D9',
        'circle-ring': '#ACC4FF',
        'circle-ring2': '#5F8BFA',
        'circle-ring3': '#3D74FF',
      }
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}
