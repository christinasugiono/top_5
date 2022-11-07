/* @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*',
    './config/initializers/simple_form_tailwind.rb',
    './node_modules/flowbite/**/*.js'
  ],
  theme: {
    screens: {
      'sm': '575px',
      // => @media (max-width: 575px) { ... }

      'md': '767px',
      // => @media (max-width: 767px) { ... }

      'lg': '992px',
      // => @media (max-width: 992px) { ... }

      'xl': '1279px',
      // => @media (max-width: 1279px) { ... }
    },
    extend: {
      colors: {
        'primary': '#8F00FF',
        'light-primary': 'rgba(230, 211, 245, 0.5)',
        'gray': '#0f0616'
      },
    },
  },
  plugins: [
    require('flowbite/plugin')
  ]
}
