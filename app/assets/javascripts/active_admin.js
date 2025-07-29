//= require active_admin/base
document.addEventListener("DOMContentLoaded", function () {
  const csrfToken = document.querySelector('meta[name="csrf-token"]').content;

  document.querySelectorAll(".alert-toggle").forEach((toggle) => {
    toggle.addEventListener("change", function () {
      const alertId = this.dataset.id;

      // Only proceed if this checkbox was turned ON
      if (this.checked) {
        fetch(`/emergency_alerts/${alertId}/activate`, {
          method: "PATCH",
          headers: {
            "Content-Type": "application/json",
            "X-CSRF-Token": csrfToken
          },
          body: JSON.stringify({})
        })
        .then((res) => {
          if (!res.ok) throw new Error("Network response was not ok.");
          return res.json();
        })
        .then((data) => {
          if (data.success) {
            // Uncheck all other toggles
            document.querySelectorAll(".alert-toggle").forEach((el) => {
              if (el.dataset.id !== alertId) el.checked = false;
            });
          } else {
            alert("Failed to activate alert.");
            this.checked = false;
          }
        })
        .catch(() => {
          alert("Error activating alert.");
          this.checked = false;
        });
      }
    });
  });
});
