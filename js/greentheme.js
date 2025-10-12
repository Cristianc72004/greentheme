/**
 * GreenTheme JS – Interactividad para acordeones
 * - Cierra otros acordeones al abrir uno
 * - Reinicia el scroll al cerrar
 * - Añade animación activa
 */
document.addEventListener("DOMContentLoaded", function () {
  const accordions = document.querySelectorAll(".gwn-accordion input[type='checkbox']");

  accordions.forEach((checkbox) => {
    const panel = checkbox.parentElement.querySelector(".gwn-acc-content");

    checkbox.addEventListener("change", function () {
      if (!checkbox.checked) {
        panel.scrollTo({ top: 0, behavior: "auto" });
      } else {
        // Cierra los demás
        accordions.forEach((other) => {
          if (other !== checkbox && other.checked) {
            other.checked = false;
            const otherPanel = other.parentElement.querySelector(".gwn-acc-content");
            otherPanel.scrollTo({ top: 0, behavior: "auto" });
          }
        });
      }
    });
  });
});
