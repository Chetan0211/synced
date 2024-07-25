const defaultTheme = require('tailwindcss/defaultTheme')
module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}',
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
      zIndex: {
        '-1': '-1',
        '-2': '-2',
      },
      height: {
        '80vh': '80vh',
        '100vh': '100vh',
      },
      width: {
        '100vh': '100vh' 
      },
      colors: {
        'primary-color': {
          'default': '#ff5758', // This is a primary color
          50: '#ffe5e5',
          100: '#ffcccc',
          200: '#ff999a',
          300: '#ff6667',
          400: '#ff3334',
          500: '#ff0001',
          600: '#e60000',
          700: '#cc0000',
          800: '#b30000',
          900: '#990000',
        }
      }
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}
