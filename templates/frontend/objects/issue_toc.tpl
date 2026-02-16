{**
 * plugins/themes/greentheme/templates/frontend/objects/issue_toc.tpl
 * Tabla de contenidos moderna (GreenTheme) - Versión mejorada con imágenes
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
					
					{* Grid de artículos con soporte para imágenes *}
					<div class="gwj-article-grid">
						{foreach from=$section.articles item=article}
							{assign var=publication value=$article->getCurrentPublication()}
							{assign var=articlePath value=$article->getBestId($currentJournal)}
							{assign var=coverImage value=$publication->getLocalizedData('coverImage')}
							
							{* Tarjeta individual de artículo *}
							<div class="gwj-article-card obj_article_summary">
								
								{* Imagen de portada del artículo *}
								{if $coverImage}
									<div class="gwj-article-cover">
										<a href="{url page="article" op="view" path=$articlePath}">
											<img 
												src="{$publication->getLocalizedCoverImageUrl($currentContext->getId())|escape}" 
												alt="{$coverImage.altText|escape|default:''}"
												class="gwj-article-thumb"
											>
										</a>
									</div>
								{/if}

								{* Contenido del artículo *}
								<div class="gwj-article-content">
									
									{* Título *}
									<h3 class="gwj-article-title">
										<a href="{url page="article" op="view" path=$articlePath}">
											{$publication->getLocalizedTitle()|strip_unsafe_html}
										</a>
									</h3>

									{* Subtítulo (si existe) *}
									{if $publication->getLocalizedSubtitle()}
										<p class="gwj-article-subtitle">
											{$publication->getLocalizedSubtitle()|escape}
										</p>
									{/if}

									{* Autores *}
									{if $publication->getData('authors')}
										<div class="gwj-article-authors">
											{foreach name=authors from=$publication->getData('authors') item=author}
												<span class="author">
													{$author->getFullName()|escape}
												</span>
												{if !$smarty.foreach.authors.last}
													{translate key="common.commaListSeparator"}
												{/if}
											{/foreach}
										</div>
									{/if}

									{* Páginas *}
									{if $publication->getData('pages')}
										<p class="gwj-article-pages">
											<strong>{translate key="article.pages"}:</strong> {$publication->getData('pages')|escape}
										</p>
									{/if}

									{* Botones de descarga (Galleys) *}
									{if $article->getGalleys()}
										<div class="gwj-article-galleys">
											{foreach from=$article->getGalleys() item=galley}
												{include file="frontend/objects/galley_link.tpl" parent=$article}
											{/foreach}
										</div>
									{/if}

								</div>
							</div>
						{/foreach}
					</div>
				{/if}
			</section>
		{/foreach}
	</div>
</div>