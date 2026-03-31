/**
 * GreenTheme – Mover referencias al final en móvil
 * - Solo mueve el bloque de referencias
 * - En móvil va al final del contenido
 * - En desktop vuelve al sidebar
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

/* =====================================================
   MENÚ HAMBURGUESA – mostrar/ocultar en móvil
   ===================================================== */
document.addEventListener("DOMContentLoaded", function () {
  const btn = document.getElementById("gwj-hamburger-btn");
  const nav = document.getElementById("gwj-nav-collapse");

  if (!btn || !nav) return;

  btn.addEventListener("click", function () {
    var isOpen = nav.classList.toggle("gwj-open");

    // Actualiza atributo accesibilidad
    btn.setAttribute("aria-expanded", isOpen ? "true" : "false");

    // Cambia ícono: ☰ abierto → ✕ cerrado
    btn.querySelector(".gwj-hamburger-icon").textContent = isOpen ? "✕" : "☰";
  });

  // Cierra el menú si se hace clic fuera de él (útil en móvil)
  document.addEventListener("click", function (e) {
    if (!btn.contains(e.target) && !nav.contains(e.target)) {
      if (nav.classList.contains("gwj-open")) {
        nav.classList.remove("gwj-open");
        btn.setAttribute("aria-expanded", "false");
        btn.querySelector(".gwj-hamburger-icon").textContent = "☰";
      }
    }
  });
});

/* =====================================================
   MENÚ ACTIVO – resalta el ítem de la página actual
   ===================================================== */
document.addEventListener("DOMContentLoaded", function () {
  var currentUrl = window.location.href.split('?')[0]; // ignora parámetros
  var menuLinks = document.querySelectorAll(".gwj-sidemenu a");

  menuLinks.forEach(function (link) {
    var linkUrl = link.href.split('?')[0];
    if (linkUrl === currentUrl) {
      link.parentElement.classList.add("active");
    }
  });
});

/* =====================================================
   ORDENAMIENTO DE ARTÍCULOS – issue_toc
   ===================================================== */
document.addEventListener("DOMContentLoaded", function () {
    var select = document.getElementById("gwj-sort-select");
    if (!select) return;

    select.addEventListener("change", function () {
        gwjSortArticles(this.value);
    });
});

function gwjSortArticles(criteria) {
    document.querySelectorAll(".gwj-article-grid").forEach(function (grid) {
        var cards = Array.from(grid.querySelectorAll(".gwj-article-card"));

        cards.sort(function (a, b) {
            if (criteria === "alpha") {
                return (a.dataset.title || "").toLowerCase()
                    .localeCompare((b.dataset.title || "").toLowerCase());

            } else if (criteria === "date") {
                return (a.dataset.date || "").localeCompare(b.dataset.date || "");

            } else if (criteria === "doi") {
                return (a.dataset.doi || "").toLowerCase()
                    .localeCompare((b.dataset.doi || "").toLowerCase());

            } else {
                return parseInt(a.dataset.index || 0) - parseInt(b.dataset.index || 0);
            }
        });

        cards.forEach(function (card) {
            grid.appendChild(card);
        });
    });
}