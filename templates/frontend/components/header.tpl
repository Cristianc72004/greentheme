{**
 * plugins/themes/greentheme/templates/frontend/components/header.tpl
 * Common frontend site header (custom GreenTheme)
 *}

{* Determine whether a logo or title string is being displayed (kept for body class) *}
{assign var="showingLogo" value=true}
{if $displayPageHeaderTitle && !$displayPageHeaderLogo && is_string($displayPageHeaderTitle)}
	{assign var="showingLogo" value=false}
{/if}

<!DOCTYPE html>
<html lang="{$currentLocale|replace:"_":"-"}" xml:lang="{$currentLocale|replace:"_":"-"}">
{if !$pageTitleTranslated}{capture assign="pageTitleTranslated"}{translate key=$pageTitle}{/capture}{/if}
{include file="frontend/components/headerHead.tpl"}

{* Base URL del plugin para referenciar imágenes propias *}
{assign var=pluginBaseUrl value=$baseUrl|cat:'/plugins/themes/greentheme'}

<body class="pkp_page_{$requestedPage|escape|default:"index"} pkp_op_{$requestedOp|escape|default:"index"}{if $showingLogo} has_site_logo{/if}">
	<div class="pkp_structure_page">

		{* Accesibilidad *}
		<nav id="accessibility-nav" class="sr-only" role="navigation" aria-label="{translate|escape key="plugins.themes.greentheme.accessible_menu.label"}">
			<ul>
			  <li><a href="#main-navigation">{translate|escape key="plugins.themes.greentheme.accessible_menu.main_navigation"}</a></li>
			  <li><a href="#main-content">{translate|escape key="plugins.themes.greentheme.accessible_menu.main_content"}</a></li>
			  <li><a href="#sidebar">{translate|escape key="plugins.themes.greentheme.accessible_menu.sidebar"}</a></li>
			</ul>
		</nav>

		{* Header *}
		<header class="navbar navbar-default" id="headerNavigationContainer" role="banner">

			{* Menú de usuario (perfil, login, etc.) *}
			<div class="container-fluid">
				<div class="row">
					<nav aria-label="{translate|escape key="common.navigation.user"}">
						{load_menu name="user" id="navigationUser" ulClass="nav nav-pills tab-list pull-right"}
					</nav>
				</div><!-- .row -->
			</div><!-- .container-fluid -->

			{* Bloque de marca: logo + título + e-ISSN + logos aliados *}
			<div class="container gwj-header">
				<div class="row">
					<div class="col-sm-8">
						{capture assign="homeUrl"}{url page="index" router=\PKP\core\PKPApplication::ROUTE_PAGE}{/capture}
						<a class="gwj-brand" href="{$homeUrl}">
							<img class="gwj-logo" src="{$pluginBaseUrl}/images/logo-gwj.png" alt="{$currentContext->getLocalizedName()|escape}">
							<div>
								<div class="gwj-title">{$currentContext->getLocalizedName()|escape}</div>
								<div class="gwj-issn">e-ISSN 2737-6109</div>
							</div>
						</a>
					</div>
					<div class="col-sm-4 text-right">
						<div class="partner-logos">
							{* Descomenta o sustituye según tus archivos reales *}
							<img src="{$pluginBaseUrl}/images/camera.png" alt="CaMeRa">
							<img src="{$pluginBaseUrl}/images/latindex.jpg" alt="Latindex">
							<img src="{$pluginBaseUrl}/images/road.jpg" alt="ROAD">
						</div>
					</div>
				</div>
			</div>

			{* Contenedor de navegación principal + buscador *}
			<div class="container-fluid">

				<div class="navbar-header">
					{* Botón hamburguesa móvil *}
					<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#nav-menu" aria-expanded="false" aria-controls="nav-menu">
						<span class="sr-only">Toggle navigation</span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</button>
				</div>

				{* Menú de navegación principal *}
				{capture assign="primaryMenu"}
					{load_menu name="primary" id="main-navigation" ulClass="nav navbar-nav"}
				{/capture}

				{if !empty(trim($primaryMenu)) || $currentContext}
					<nav id="nav-menu" class="navbar-collapse collapse" aria-label="{translate|escape key="common.navigation.site"}">
						{$primaryMenu}

						{* Buscador *}
						{if $currentContext}
							<div class="pull-md-right">
								{include file="frontend/components/searchForm_simple.tpl"}
							</div>
						{/if}
					</nav>
				{/if}

			</div><!-- .container-fluid -->
		</header><!-- .pkp_structure_head -->

		{* Contenedor de contenido y sidebars *}
		<div class="pkp_structure_content container">
			<main class="pkp_structure_main col-xs-12 col-sm-10 col-md-8" role="main">
