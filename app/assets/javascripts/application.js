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

  document.querySelectorAll(".board_member_action_icon").forEach(function(icon) {
    icon.addEventListener("click", function() {
      var note = this.getAttribute("data-note");
      console.log(note);
      this.parentElement.querySelectorAll(".board_member_action_icon").forEach(function(sibling) {
        sibling.classList.remove("show_note");
      });
      this.classList.add("show_note");

      var socialContainer = this.parentElement.parentElement.querySelector(".board_member_social");

      socialContainer.querySelectorAll(".board_member_social .board_member_note").forEach(function(noteElem) {
        if (noteElem.className.indexOf(note) !== -1) {
          noteElem.style.display = "block"; // show
        } else {
          noteElem.style.display = "none"; // hide
        }
      });
    });
  });

  document.querySelectorAll(".dropdown-submenu a.submenu_item .caret").forEach(function (el) {
    el.addEventListener("click", function (e) {
      e.preventDefault();
      e.stopPropagation();
      const submenu = this.parentElement.nextElementSibling;
      if (submenu) {
        submenu.style.display = submenu.style.display === "block" ? "none" : "block";
      }
    });
  });

  document.querySelector(".alert_close").addEventListener("click", function () {
    document.querySelector(".emergency_alert_wrapper").style.display = "none";
  });

  document.querySelector(".emergency_icon").addEventListener("click", function () {
    document.querySelector(".emergency_alert_wrapper").style.display = "block";
  });
});
