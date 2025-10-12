<?php
/**
 * @file plugins/themes/greentheme/GreenThemePlugin.php
 *
 * Tema GreenTheme basado en Bootstrap 3.
 * Distribuido bajo la GNU GPL v3.
 */

namespace APP\plugins\themes\greentheme;

use APP\core\Application;
use PKP\config\Config;
use PKP\facades\Locale;
use PKP\plugins\ThemePlugin;

class GreenThemePlugin extends ThemePlugin
{
    /**
     * Inicializa el tema
     */
    public function init()
    {
        // Opción: selección de subtema Bootstrap
        $this->addOption('bootstrapTheme', 'FieldOptions', [
            'type' => 'radio',
            'label' => __('plugins.themes.greentheme.options.bootstrapTheme.label'),
            'description' => __('plugins.themes.greentheme.options.bootstrapTheme.description'),
            'options' => [
                [ 'value' => 'bootstrap3', 'label' => __('plugins.themes.greentheme.options.bootstrapTheme.bootstrap3') ],
                [ 'value' => 'cerulean',   'label' => __('plugins.themes.greentheme.options.bootstrapTheme.cerulean') ],
                [ 'value' => 'cleanblog',  'label' => __('plugins.themes.greentheme.options.bootstrapTheme.cleanblog') ],
                [ 'value' => 'cosmo',      'label' => __('plugins.themes.greentheme.options.bootstrapTheme.cosmo') ],
                [ 'value' => 'cyborg',     'label' => __('plugins.themes.greentheme.options.bootstrapTheme.cyborg') ],
                [ 'value' => 'darkly',     'label' => __('plugins.themes.greentheme.options.bootstrapTheme.darkly') ],
                [ 'value' => 'flatly',     'label' => __('plugins.themes.greentheme.options.bootstrapTheme.flatly') ],
                [ 'value' => 'journal',    'label' => __('plugins.themes.greentheme.options.bootstrapTheme.journal') ],
                [ 'value' => 'lumen',      'label' => __('plugins.themes.greentheme.options.bootstrapTheme.lumen') ],
                [ 'value' => 'paper',      'label' => __('plugins.themes.greentheme.options.bootstrapTheme.paper') ],
                [ 'value' => 'readable',   'label' => __('plugins.themes.greentheme.options.bootstrapTheme.readable') ],
                [ 'value' => 'sandstone',  'label' => __('plugins.themes.greentheme.options.bootstrapTheme.sandstone') ],
                [ 'value' => 'simplex',    'label' => __('plugins.themes.greentheme.options.bootstrapTheme.simplex') ],
                [ 'value' => 'slate',      'label' => __('plugins.themes.greentheme.options.bootstrapTheme.slate') ],
                [ 'value' => 'spacelab',   'label' => __('plugins.themes.greentheme.options.bootstrapTheme.spacelab') ],
                [ 'value' => 'superhero',  'label' => __('plugins.themes.greentheme.options.bootstrapTheme.superhero') ],
                [ 'value' => 'united',     'label' => __('plugins.themes.greentheme.options.bootstrapTheme.united') ],
                [ 'value' => 'yeti',       'label' => __('plugins.themes.greentheme.options.bootstrapTheme.yeti') ],
            ],
            'default' => 'bootstrap3',
        ]);

        // Opción: visualización de estadísticas
        $this->addOption('displayStats', 'FieldOptions', [
            'type' => 'radio',
            'label' => __('plugins.themes.greentheme.option.displayStats.label'),
            'options' => [
                [ 'value' => 'none', 'label' => __('plugins.themes.greentheme.option.displayStats.none') ],
                [ 'value' => 'bar',  'label' => __('plugins.themes.greentheme.option.displayStats.bar') ],
                [ 'value' => 'line', 'label' => __('plugins.themes.greentheme.option.displayStats.line') ],
            ],
            'default' => 'none',
        ]);

        // Ruta al font de glyphicons de Bootstrap
        $iconFontPath = Application::get()->getRequest()->getBaseUrl() . '/' . $this->getPluginPath() . '/bootstrap/fonts/';

        // Carga del CSS según el subtema elegido
        $bootstrapTheme = $this->getOption('bootstrapTheme');
        if (empty($bootstrapTheme) || $bootstrapTheme === 'bootstrap3') {
            $this->addStyle('bootstrap', 'styles/bootstrap.less');
            $this->modifyStyle('bootstrap', ['addLessVariables' => '@icon-font-path:"' . $iconFontPath . '";']);
        } else {
            $this->addStyle('bootstrapTheme-' . $bootstrapTheme, 'styles/' . $bootstrapTheme . '.less');
            $this->modifyStyle('bootstrapTheme-' . $bootstrapTheme, ['addLessVariables' => '@icon-font-path:"' . $iconFontPath . '";']);
        }

        // RTL
        $locale = Locale::getLocale();
        $localeMetadata = Locale::getMetadata($locale);
        if ($localeMetadata->isRightToLeft() === 'rtl') {
            $this->addStyle('bootstrap-rtl', 'styles/bootstrap-rtl.min.css');
        }

        // ====== CSS propio del tema (logo/hero/barra de logos/overrides) ======
        // Se carga al final para sobreescribir los estilos del skin elegido.
        $this->addStyle('greentheme-custom', 'styles/greentheme.css', [
            'priority' => STYLE_SEQUENCE_LATE,
            'contexts' => 'frontend',
        ]);

        // jQuery desde build local (respetando minificación de OJS)
        $min = Config::getVar('general', 'enable_minified') ? '.min' : '';
        $request = Application::get()->getRequest();
        $jquery   = $request->getBaseUrl() . '/js/build/jquery/jquery' . $min . '.js';
        $jqueryUI = $request->getBaseUrl() . '/js/build/jquery-ui/jquery-ui' . $min . '.js';
        $this->addScript('jQuery', $jquery, ['baseUrl' => '']);
        $this->addScript('jQueryUI', $jqueryUI, ['baseUrl' => '']);
        $this->addScript('jQueryTagIt', $request->getBaseUrl() . '/lib/pkp/js/lib/jquery/plugins/jquery.tag-it.js', ['baseUrl' => '']);

        // Bootstrap JS
        $this->addScript('bootstrap', 'bootstrap/js/bootstrap.min.js');

        // Áreas de menú disponibles
        $this->addMenuArea(['primary', 'user']);
    }

    /** Nombre visible del plugin */
    public function getDisplayName()
    {
        return __('plugins.themes.greentheme.name');
    }

    /** Descripción visible del plugin */
    public function getDescription()
    {
        return __('plugins.themes.greentheme.description');
    }
}

// Alias (compatibilidad si PKP_STRICT_MODE está desactivado)
if (!defined('PKP_STRICT_MODE') || !PKP_STRICT_MODE) {
    class_alias('\APP\plugins\themes\greentheme\GreenThemePlugin', '\GreenThemePlugin');
}
