{**
 * plugins/themes/greentheme/templates/frontend/components/footer.tpl
 * Common frontend site footer (GreenTheme con sidebar global)
 *}

			</main> {* cierre del main abierto en header.tpl *}
		</div>   {* cierre .row *}
	</div>     {* cierre .pkp_structure_content .container *}

	{* Footer del sitio *}
	<footer class="site-footer" role="contentinfo">
		<div class="container">
			<div class="row">
				<div class="col-sm-6">
					<p class="copyright">
						&copy; {$smarty.now|date_format:"%Y"} {$currentContext->getLocalizedName()|escape}
					</p>
				</div>
				<div class="col-sm-6 text-right">
					{* Marca OJS/PKP (oculta por CSS si no la quieres) *}
					<div class="pkp_branding">
						{if $pageFooter}{* contenido configurable desde Apariencia *}
							{$pageFooter}
						{/if}
					</div>
				</div>
			</div>
		</div>
	</footer>

</div> {* cierre .pkp_structure_page *}

{load_script context="frontend"}
</body>
</html>
