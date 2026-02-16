/**
 * GreenTheme – Acordeones (scroll reset + exclusivo)
 */
document.addEventListener("DOMContentLoaded", function () {
  const accordions = document.querySelectorAll(".gwn-accordion input[type='checkbox']");
  accordions.forEach((checkbox) => {
    const panel = checkbox.parentElement.querySelector(".gwn-acc-content");
    checkbox.addEventListener("change", function () {
      if (!checkbox.checked) {
        panel.scrollTo({ top: 0, behavior: "auto" });
      } else {
        // Cierra otros
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

/**
 * GreenTheme – Mover referencias al final en móvil (≤990px)
 * - Solo mueve el bloque de referencias
 * - En desktop vuelve al sidebar
 */
document.addEventListener("DOMContentLoaded", function () {
  const refs = document.querySelector(".article-references--sidebar");
  const sidebar = document.querySelector(".article-sidebar");
  const mainCol = document.querySelector(".article-details .col-md-8");
  if (!refs || !sidebar || !mainCol) return;

  const placeholder = document.createComment("references-placeholder");
  sidebar.insertBefore(placeholder, refs);

  function moveReferencesResponsive() {
    if (window.innerWidth <= 990) {
      if (!refs.classList.contains("refs-moved")) {
        mainCol.appendChild(refs);
        refs.classList.add("refs-moved");
      }
    } else {
      if (refs.classList.contains("refs-moved")) {
        placeholder.parentNode.insertBefore(refs, placeholder.nextSibling);
        refs.classList.remove("refs-moved");
      }
    }
  }
  moveReferencesResponsive();
  window.addEventListener("resize", moveReferencesResponsive);
});

/**
 * GreenTheme – Fallback de Lazy‑load para portadas en TOC
 * - OJS o algunos temas dejan las imágenes con data-src/data-load-src
 * - Si el loader no corre, el <img> queda sin src → no se ve. Lo corregimos.
 * - También soporta portadas con background vía data-cover/data-bg
 */
document.addEventListener("DOMContentLoaded", function () {
  // 1) <img> con data-atributos (sin src)
  document.querySelectorAll(
    '.obj_issue_toc .obj_article_summary img[data-src]:not([src]),' +
    '.obj_issue_toc .obj_article_summary img[data-load-src]:not([src]),' +
    '.obj_issue_toc .obj_article_summary img[data-href]:not([src])'
  ).forEach(function (img) {
    if (img.getAttribute('src')) return;
    var ds = img.getAttribute('data-src') ||
             img.getAttribute('data-load-src') ||
             img.getAttribute('data-href');
    if (ds) img.setAttribute('src', ds);
  });

  // 2) Contenedores con data-cover para background
  document.querySelectorAll(
    '.obj_issue_toc .obj_article_summary [data-cover],' +
    '.obj_issue_toc .obj_article_summary [data-cover-image],' +
    '.obj_issue_toc .obj_article_summary [data-bg]'
  ).forEach(function (el) {
    var url = el.getAttribute('data-cover') ||
              el.getAttribute('data-cover-image') ||
              el.getAttribute('data-bg');
    if (url && !el.style.backgroundImage) {
      el.style.backgroundImage = 'url("' + url + '")';
      el.classList.add('has-cover-bg');
    }
  });
});