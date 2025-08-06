document.addEventListener("DOMContentLoaded", function () {
  document.querySelectorAll('.card-link').forEach(link => {
    link.addEventListener('click', function () {
      const statusIcons = this.parentElement.parentElement.querySelectorAll('.status_icon');
      statusIcons.forEach(icon => {
        if (icon.classList.contains('show')) {
          icon.classList.remove('show');
          icon.classList.add('hide');
        } else if (icon.classList.contains('hide')) {
          icon.classList.remove('hide');
          icon.classList.add('show');
        }
      });
    });
  });
});
