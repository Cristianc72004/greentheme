{**
 * plugins/themes/greentheme/templates/frontend/components/languageSwitcher.tpl
 * Selector de idioma universal y funcional (OJS 3.3 - 3.5)
 *}

{* Obtenemos los idiomas disponibles desde el contexto o del sitio global *}
{if $currentContext}
    {assign var="locales" value=$currentContext->getSupportedLocaleNames()}
{else}
    {assign var="locales" value=$site->getSupportedLocaleNames()}
{/if}

{assign var="currentLocale" value=$currentLocale}

{if $locales && $locales|@count > 1}
<div id="{$id|escape}" class="gwj-language-switcher dropdown">
    <button class="btn btn-light dropdown-toggle" type="button" id="dropdownLang" data-bs-toggle="dropdown" aria-expanded="false">
        {$locales[$currentLocale]|escape}
    </button>

    <ul class="dropdown-menu" aria-labelledby="dropdownLang">
        {foreach from=$locales item="localeName" key="localeKey"}
            {if $localeKey != $currentLocale}
                <li>
                    <a class="dropdown-item"
                       href="{url router=$smarty.const.ROUTE_PAGE page='user' op='setLocale' path=$localeKey source=$smarty.server.REQUEST_URI}">
                        {$localeName|escape}
                    </a>
                </li>
            {/if}
        {/foreach}
    </ul>
</div>
{/if}
