{**
 * plugins/themes/greentheme/templates/frontend/components/footer.tpl
 * Footer personalizado para Green World Journal
 *}

			</main> {* cierre del main abierto en header.tpl *}
		</div>   {* cierre .row *}
	</div>     {* cierre .pkp_structure_content .container *}

	{* Footer del sitio *}
	<footer id="site-footer" class="gwj-footer" role="contentinfo">
		<div class="container">
			<div class="row">
				<!-- Columna izquierda: información editorial -->
				<div class="col-sm-8 footer-info">
					<p>
						<strong>Editorial Office</strong> / Ecuador, Sucumbíos, Nueva Loja /
						<a href="mailto:editor@greenworldjournal.com">editor@greenworldjournal.com</a>
					</p>
					<p>
						© 2018 - 2023 &nbsp; CaMeRa / Green World Journal &nbsp; - &nbsp;
						<a href="https://portal.issn.org/resource/ISSN/2737-6109#" target="_blank" rel="noopener">
							e-ISSN 2737-6109
						</a>
					</p>
				</div>

				<!-- Columna derecha: redes sociales -->
				<div class="col-sm-4 footer-social text-right">
					<a href="https://www.facebook.com/GreenWorldJournal?view_public_for=108803664260239#" target="_blank" rel="noopener">
						<img src="{$baseUrl}/plugins/themes/greentheme/images/facebook-round.png" alt="Facebook" class="social-icon">
					</a>
					<a href="https://scholar.google.es/citations?user=c4LEJs8AAAAJ&hl=es&authuser=2" target="_blank" rel="noopener">
						<img src="{$baseUrl}/plugins/themes/greentheme/images/google-round.png" alt="Google Scholar" class="social-icon">
					</a>
				</div>
			</div>
		</div>
	</footer>

</div> {* cierre .pkp_structure_page *}

{load_script context="frontend"}
</body>
</html>
