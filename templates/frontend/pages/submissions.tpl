{**
 * plugins/themes/greentheme/templates/frontend/pages/submissions.tpl
 * Versión GreenTheme: Envíos modernos con acordeones (solo CSS)
 * Mantiene: login/nuevo envío/envíos pendientes
 * Añade: Documentos adicionales con scroll reiniciable
 *}
{include file="frontend/components/header.tpl" pageTitle="about.submissions"}

<div id="main-content" class="page page_submissions gwn-submissions">

	{include file="frontend/components/breadcrumbs.tpl" currentTitleKey="about.submissions"}

	<section class="gwn-header">
		<div class="gwn-header-bg">
			<h1 class="gwn-title">{translate key="about.submissions"}</h1>
			<p class="gwn-subtitle">
				Comparte tu investigación con el mundo, de forma ética y transparente.
			</p>
			<a href="{$baseUrl}/plugins/themes/greentheme/Doc/guia_autores.pdf" class="gwn-btn-download" target="_blank">
				Descargar guía completa (PDF)
			</a>
		</div>
	</section>

	{* Bloque original de envío y usuario *}
	{if $isUserLoggedIn}
		{capture assign="newSubmission"}<a class="alert-link" href="{url page="submission" op="wizard"}">{translate key="about.onlineSubmissions.newSubmission"}</a>{/capture}
		{capture assign="viewSubmissions"}<a class="alert-link" href="{url page="submissions"}">{translate key="about.onlineSubmissions.viewSubmissions"}</a>{/capture}
		<div class="alert alert-info">
			{translate key="about.onlineSubmissions.submissionActions" newSubmission=$newSubmission viewSubmissions=$viewSubmissions}
		</div>
	{else}
		{capture assign="login"}<a class="alert-link" href="{url page="login"}">{translate key="about.onlineSubmissions.login"}</a>{/capture}
		{capture assign="register"}<a class="alert-link" href="{url page="user" op="register"}">{translate key="about.onlineSubmissions.register"}</a>{/capture}
		<div class="alert alert-info">
			{translate key="about.onlineSubmissions.registrationRequired" login=$login register=$register}
		</div>
	{/if}

	<div class="gwn-submission-body container">

		{* ==== Directrices ==== *}
		{if $currentJournal->getLocalizedData('authorGuidelines')}
			<div class="gwn-accordion">
				<input type="checkbox" id="acc1" />
				<label class="gwn-acc-title" for="acc1">Directrices para autores/as</label>
				<div class="gwn-acc-content">
					{$currentJournal->getLocalizedData('authorGuidelines')}
				</div>
			</div>
		{/if}

		{* ==== Lista de comprobación ==== *}
		{if $submissionChecklist}
			<div class="gwn-accordion">
				<input type="checkbox" id="acc2" />
				<label class="gwn-acc-title" for="acc2">Lista de comprobación para la preparación de envíos</label>
				<div class="gwn-acc-content">
					{$submissionChecklist}
				</div>
			</div>
		{/if}

		{* ==== Derechos de autor ==== *}
		{if $currentJournal->getLocalizedData('copyrightNotice')}
			<div class="gwn-accordion">
				<input type="checkbox" id="acc3" />
				<label class="gwn-acc-title" for="acc3">Derechos de autor</label>
				<div class="gwn-acc-content">
					{$currentJournal->getLocalizedData('copyrightNotice')}
				</div>
			</div>
		{/if}

		{* ==== Documentos adicionales ==== *}
		<div class="gwn-accordion">
			<input type="checkbox" id="acc4" />
			<label class="gwn-acc-title" for="acc4">Documentos adicionales</label>
			<div class="gwn-acc-content">
				<ul>
					<li><a href="{$baseUrl}/plugins/themes/greentheme/Doc/plantilla-articulo.docx" target="_blank">📘 Plantilla del artículo</a></li>
					<li><a href="{$baseUrl}/plugins/themes/greentheme/Doc/guia_citaciones.pdf" target="_blank">📗 Guía de citaciones (APA 7ª edición)</a></li>
					<li><a href="{$baseUrl}/plugins/themes/greentheme/Doc/guia_autores.pdf" target="_blank">📗 Guía completa para autores/as (PDF)</a></li>
				</ul>
			</div>
		</div>

	</div>
</div>

{include file="common/frontend/footer.tpl"}
