/* @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*',
    './config/initializers/simple_form_tailwind.rb'
  ],
  theme: {
    extend: {
      colors: {
        'primary': '#8F00FF',
        'light-primary': 'rgba(230, 211, 245, 0.5)',
        'gray': '#0f0616'
      },
    },
  },
  plugins: [],
  mode: "jit"
}
