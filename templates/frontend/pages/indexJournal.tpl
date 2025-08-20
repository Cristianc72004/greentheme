{**
 * plugins/themes/greentheme/templates/frontend/pages/indexJournal.tpl
 *
 * Portada de la revista con hero fijo (GreenTheme)
 *}

{include file="frontend/components/header.tpl" pageTitleTranslated=$currentJournal->getLocalizedName()}

{* Base URL del plugin para imágenes propias *}
{assign var=pluginBaseUrl value=$baseUrl|cat:'/plugins/themes/greentheme'}

<div id="main-content" class="page_index_journal">

	{call_hook name="Templates::Index::journal"}

	{* ==== HERO de portada (imagen fija del plugin) ==== *}
	{* Quitamos el .container para reducir el margen entre el menú (col-sm-3) y la imagen *}
	<div class="gwj-hero">
		<img src="{$pluginBaseUrl}/images/fondo.jpg" alt="{$currentJournal->getLocalizedName()|escape}">
		<div class="gwj-cta">
	<a class="gwj-submit-btn"
	   href="{url router=\PKP\core\PKPApplication::ROUTE_PAGE page="about" op="submissions"}">
		{translate key="about.submissions"}
	</a>
</div>
	</div>

	{* ==== Imagen de inicio de OJS (desactivada para usar el hero del tema) ==== *}
	{*
	{if $homepageImage}
		<div class="homepage-image">
			<img class="img-responsive" src="{$publicFilesDir}/{$homepageImage.uploadName|escape:"url"}" alt="{$homepageImageAltText|escape}">
		</div>
	{/if}
	*}

	{* Descripción de la revista *}
	{if $journalDescription}
		<div class="journal-description container">
			{$journalDescription}
		</div>
	{/if}

	{* Anuncios *}
	{if $numAnnouncementsHomepage && $announcements|count}
		<section class="cmp_announcements media container">
			<header class="page-header">
				<h2>{translate key="announcement.announcements"}</h2>
			</header>
			<div class="media-list">
				{foreach name=announcements from=$announcements item=announcement}
					{if $smarty.foreach.announcements.iteration > $numAnnouncementsHomepage}{break}{/if}
					{include file="frontend/objects/announcement_summary.tpl" heading="h3"}
				{/foreach}
			</div>
		</section>
	{/if}

	{* Número actual *}
	{if $issue}
		<section class="current_issue container">
			<header class="page-header">
				<h2>{translate key="journal.currentIssue"}</h2>
			</header>
			<p class="current_issue_title lead">
				{$issue->getIssueIdentification()|strip_unsafe_html}
			</p>
			{include file="frontend/objects/issue_toc.tpl"}
			<a href="{url router=\PKP\core\PKPApplication::ROUTE_PAGE page="issue" op="archive"}" class="btn btn-primary read-more">
				{translate key="journal.viewAllIssues"}
				<span class="glyphicon glyphicon-chevron-right"></span>
			</a>
		</section>
	{/if}

	{* Contenido adicional *}
	{if $additionalHomeContent}
		<section class="additional_content container">
			{$additionalHomeContent}
		</section>
	{/if}
</div><!-- .page -->

{include file="frontend/components/footer.tpl"}
