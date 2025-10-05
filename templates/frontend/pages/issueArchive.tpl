{**
 * plugins/themes/greentheme/templates/frontend/pages/issueArchive.tpl
 * Vista personalizada de archivo de números (GreenTheme)
 * Compatible con OJS 3.4.x (sin getUrl())
 *}
{capture assign="pageTitle"}
    {if $prevPage}
        {translate key="archive.archivesPageNumber" pageNumber=$prevPage+1}
    {else}
        {translate key="archive.archives"}
    {/if}
{/capture}
{include file="frontend/components/header.tpl" pageTitleTranslated=$pageTitle}

<div id="main-content" class="page page_issue_archive">
    {include file="frontend/components/breadcrumbs.tpl" currentTitle=$pageTitle}

    {if empty($issues)}
        <div class="alert alert-info" role="alert">
            {translate key="current.noCurrentIssueDesc"}
        </div>
    {else}

        {assign var="lastVol" value=""}

        {foreach from=$issues item=issue name=loop}
            {assign var=currentVol value=$issue->getVolume()}

            {if $smarty.foreach.loop.first || $currentVol != $lastVol}
                {if !$smarty.foreach.loop.first}
                    </div>
                {/if}
                <div class="gwj-volume-block text-center">
                    <h2 class="pkp_volume_title">
                        Volume {$currentVol} ({$issue->getYear()})
                    </h2>
                </div>
                <div class="gwj-issue-grid">
            {/if}

            {assign var=cover value=$issue->getLocalizedCoverImageUrl()}

            {* Obtener URL segura mediante router (OJS 3.4) *}
            {capture assign=issueUrl}
                {url router=\PKP\core\PKPApplication::ROUTE_PAGE page="issue" op="view" path=$issue->getBestIssueId()}
            {/capture}

            <div class="gwj-issue-card">
                {if $cover}
                    <a href="{$issueUrl|trim}">
                        <img src="{$cover|escape}" alt="{$issue->getLocalizedTitle()|escape}">
                    </a>
                {/if}
                <div class="issue-info">
                    <a href="{$issueUrl|trim}" class="issue-title">
                        {$issue->getLocalizedTitle()|escape}
                    </a>
                    <div class="issue-meta">
                        {$issue->getIssueIdentification()|strip_tags}
                    </div>
                </div>
            </div>

            {assign var=lastVol value=$currentVol}
            {if $smarty.foreach.loop.last}
                </div>
            {/if}
        {/foreach}

        {* ==== Paginación original (sin tocar) ==== *}
        {if $prevPage > 1}
            {capture assign=prevUrl}{url router=\PKP\core\PKPApplication::ROUTE_PAGE page="issue" op="archive" path=$prevPage}{/capture}
        {elseif $prevPage === 1}
            {capture assign=prevUrl}{url router=\PKP\core\PKPApplication::ROUTE_PAGE page="issue" op="archive"}{/capture}
        {/if}
        {if $nextPage}
            {capture assign=nextUrl}{url router=\PKP\core\PKPApplication::ROUTE_PAGE page="issue" op="archive" path=$nextPage}{/capture}
        {/if}
        {include
            file="frontend/components/pagination.tpl"
            prevUrl=$prevUrl
            nextUrl=$nextUrl
            showingStart=$showingStart
            showingEnd=$showingEnd
            total=$total
        }
    {/if}
</div>

{include file="common/frontend/footer.tpl"}
