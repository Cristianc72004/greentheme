{**
 * plugins/themes/greentheme/templates/frontend/objects/issue_toc.tpl
 * Tabla de contenidos moderna (GreenTheme)
 *}
<div class="gwj-issue-toc">

	{if !$issue->getPublished()}
		{include file="frontend/components/notification.tpl" type="warning" messageKey="editor.issues.preview"}
	{/if}

	{* === CABECERA DEL NÚMERO === *}
	<div class="gwj-issue-header">
		{assign var=cover value=$issue->getLocalizedCoverImageUrl()}

		{if $cover}
			<div class="gwj-issue-cover">
				<img src="{$cover|escape}" alt="{$issue->getLocalizedCoverImageAltText()|escape}">
			</div>
		{/if}

		<div class="gwj-issue-info">
			<h1 class="gwj-issue-title">{$issueIdentification|escape}</h1>

			{if $issue->hasDescription()}
				<p class="gwj-issue-desc">
					{$issue->getLocalizedDescription()|strip_unsafe_html}
				</p>
			{/if}

			{if $issue->getDatePublished()}
				<p class="gwj-issue-date">
					<strong>{translate key="submissions.published"}:</strong>
					{$issue->getDatePublished()|escape|date_format:$dateFormatShort}
				</p>
			{/if}

			{foreach from=$pubIdPlugins item=pubIdPlugin}
				{assign var=pubId value=$issue->getStoredPubId($pubIdPlugin->getPubIdType())}
				{if $pubId}
					{assign var=doiUrl value=$pubIdPlugin->getResolvingURL($currentJournal->getId(), $pubId)|escape}
					<p class="gwj-issue-doi">
						<strong>{$pubIdPlugin->getPubIdDisplayType()|escape}:</strong>
						<a href="{$doiUrl}" target="_blank">{$doiUrl}</a>
					</p>
				{/if}
			{/foreach}
		</div>
	</div>

	{* === GALLEYS COMPLETOS (PDFs del número) === *}
	{if $issueGalleys}
		<div class="gwj-full-issue">
			<h2>{translate key="issue.fullIssue"}</h2>
			<div class="gwj-galleys-btns">
				{foreach from=$issueGalleys item=galley}
					{include file="frontend/objects/galley_link.tpl" parent=$issue}
				{/foreach}
			</div>
		</div>
	{/if}

	{* === ARTÍCULOS === *}
	<div class="gwj-issue-articles">
		{foreach name=sections from=$publishedSubmissions item=section}
			<section class="gwj-section">
				{if $section.articles}
					{if $section.title}
						<h2 class="gwj-section-title">{$section.title|escape}</h2>
					{/if}
					<div class="gwj-article-grid">
						{foreach from=$section.articles item=article}
							{include file="frontend/objects/article_summary.tpl"}
						{/foreach}
					</div>
				{/if}
			</section>
		{/foreach}
	</div>
</div>
