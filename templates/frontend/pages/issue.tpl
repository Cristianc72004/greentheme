{**
 * plugins/themes/greentheme/templates/frontend/pages/issue.tpl
 * Diseño moderno (GreenTheme) para la vista de un número específico
 * Compatible con OJS 3.4.x
 *}
{include file="frontend/components/header.tpl" pageTitleTranslated=$issueIdentification}

<div id="main-content" class="page page_issue gwn-issue">

	{if !$issue}
		{include file="frontend/components/breadcrumbs_issue.tpl" currentTitleKey="current.noCurrentIssue"}
		{include file="frontend/components/notification.tpl" type="warning" messageKey="current.noCurrentIssueDesc"}
	{else}
		{include file="frontend/components/breadcrumbs_issue.tpl" currentTitle=$issueIdentification}
		{include file="frontend/objects/issue_toc.tpl"}
	{/if}

</div>

{include file="common/frontend/footer.tpl"}
