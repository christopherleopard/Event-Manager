module.exports = {
  content: ["./app/**/*.html.erb", "./app/assets/**/*.css"],
  theme: {
    extend: {
      colors: {
      primary: '#D32128',
      secondary: '#979797',
      body: '#3E3E3E',
    }
    }
  },
  plugins: [],
  safelist: [
    'text-primary',
    'bg-primary',
    'text-body',
  ],
}
