/**
 * GreenTheme – Mover referencias al final en móvil
 * - Solo mueve el bloque de referencias
 * - En móvil va al final del contenido
 * - En desktop vuelve al sidebar
 */
document.addEventListener("DOMContentLoaded", function () {

  const refs = document.querySelector(".article-references--sidebar");
  const sidebar = document.querySelector(".article-sidebar");
  const mainCol = document.querySelector(".article-details .col-md-8");

  if (!refs || !sidebar || !mainCol) return;

  // Guardamos la posición original
  const placeholder = document.createComment("references-placeholder");
  sidebar.insertBefore(placeholder, refs);

  function moveReferencesResponsive() {
    if (window.innerWidth <= 990) {
      // 👉 Móvil: mover referencias al final del contenido
      if (!refs.classList.contains("refs-moved")) {
        mainCol.appendChild(refs);
        refs.classList.add("refs-moved");
      }
    } else {
      // 👉 Desktop: volver a sidebar
      if (refs.classList.contains("refs-moved")) {
        placeholder.parentNode.insertBefore(refs, placeholder.nextSibling);
        refs.classList.remove("refs-moved");
      }
    }
  }

  moveReferencesResponsive();
  window.addEventListener("resize", moveReferencesResponsive);
});


