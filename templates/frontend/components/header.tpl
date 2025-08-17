{**
 * plugins/themes/greentheme/templates/frontend/components/header.tpl
 * Common frontend site header (GreenTheme con sidebar global)
 *}

{assign var="showingLogo" value=true}
{if $displayPageHeaderTitle && !$displayPageHeaderLogo && is_string($displayPageHeaderTitle)}
	{assign var="showingLogo" value=false}
{/if}

<!DOCTYPE html>
<html lang="{$currentLocale|replace:"_":"-"}" xml:lang="{$currentLocale|replace:"_":"-"}">
{if !$pageTitleTranslated}{capture assign="pageTitleTranslated"}{translate key=$pageTitle}{/capture}{/if}
{include file="frontend/components/headerHead.tpl"}

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

		{* HEADER (logo + logos aliados + user menu + buscador) *}
		<header class="navbar navbar-default" id="headerNavigationContainer" role="banner">

			{* Menú de usuario (perfil, login, etc.) *}
			<div class="container-fluid">
				<div class="row">
					<nav aria-label="{translate|escape key="common.navigation.user"}">
						{load_menu name="user" id="navigationUser" ulClass="nav nav-pills tab-list pull-right"}
					</nav>
				</div>
			</div>

			{* Branding *}
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
							<img src="{$pluginBaseUrl}/images/camera.png" alt="CaMeRa">
							<img src="{$pluginBaseUrl}/images/latindex.jpg" alt="Latindex">
							<img src="{$pluginBaseUrl}/images/road.jpg" alt="ROAD">
						</div>
					</div>
				</div>
			</div>

			{* Buscador (dejamos el primary nav SOLO en el sidebar global) *}
			<div class="container">
				{if $currentContext}
					<div class="row">
						<div class="col-sm-6 col-sm-offset-6 text-right">
							{include file="frontend/components/searchForm_simple.tpl"}
						</div>
					</div>
				{/if}
			</div>

		</header><!-- .pkp_structure_head -->

		{* ====== LAYOUT GLOBAL: SIDEBAR IZQUIERDO (MENÚ VERTICAL) + MAIN ====== *}
		<div class="pkp_structure_content container">
			<div class="row">

				{* Sidebar global con el menú principal vertical *}
				<aside id="sidebar" class="gwj-sidebar col-sm-3" role="navigation" aria-label="{translate|escape key="plugins.themes.greentheme.accessible_menu.main_navigation"}">
					<nav class="gwj-sidemenu">
						{load_menu name="primary" id="main-navigation" ulClass="nav nav-pills nav-stacked"}
					</nav>
				</aside>

				{* Contenido de cada página *}
				<main id="main-content" class="pkp_structure_main col-xs-12 col-sm-9" role="main">
