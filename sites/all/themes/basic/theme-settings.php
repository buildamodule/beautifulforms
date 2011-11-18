<?php
// Form override fo theme settings
function basic_form_system_theme_settings_alter(&$form, $form_state) {

  $form['options_settings'] = array(
    '#type' => 'fieldset',
    '#title' => t('Theme Specific Settings'),
    '#collapsible' => FALSE,
    '#collapsed' => FALSE
  );
  $form['options_settings']['basic_tabs'] = array(
    '#type' => 'checkbox',
    '#title' =>  t('Use the ZEN tabs'),
    '#description'   => t('Check this if you wish to replace the default tabs by the ZEN tabs'),
    '#default_value' => theme_get_setting('basic_tabs'),
  );
  
  $form['options_settings']['basic_breadcrumb'] = array(
    '#type'          => 'fieldset',
    '#title'         => t('Breadcrumb settings'),
    '#attributes'    => array('id' => 'basic-breadcrumb'),
  );
  $form['options_settings']['basic_breadcrumb']['basic_breadcrumb'] = array(
    '#type'          => 'select',
    '#title'         => t('Display breadcrumb'),
    '#default_value' => theme_get_setting('basic_breadcrumb'),
    '#options'       => array(
                          'yes'   => t('Yes'),
                          'admin' => t('Only in admin section'),
                          'no'    => t('No'),
                        ),
  );
  $form['options_settings']['basic_breadcrumb']['basic_breadcrumb_separator'] = array(
    '#type'          => 'textfield',
    '#title'         => t('Breadcrumb separator'),
    '#description'   => t('Text only. Don’t forget to include spaces.'),
    '#default_value' => theme_get_setting('basic_breadcrumb_separator'),
    '#size'          => 5,
    '#maxlength'     => 10,
    '#prefix'        => '<div id="div-basic-breadcrumb-collapse">', // jquery hook to show/hide optional widgets
  );
  $form['options_settings']['basic_breadcrumb']['basic_breadcrumb_home'] = array(
    '#type'          => 'checkbox',
    '#title'         => t('Show home page link in breadcrumb'),
    '#default_value' => theme_get_setting('basic_breadcrumb_home'),
  );
  $form['options_settings']['basic_breadcrumb']['basic_breadcrumb_trailing'] = array(
    '#type'          => 'checkbox',
    '#title'         => t('Append a separator to the end of the breadcrumb'),
    '#default_value' => theme_get_setting('basic_breadcrumb_trailing'),
    '#description'   => t('Useful when the breadcrumb is placed just before the title.'),
  );
  $form['options_settings']['basic_breadcrumb']['basic_breadcrumb_title'] = array(
    '#type'          => 'checkbox',
    '#title'         => t('Append the content title to the end of the breadcrumb'),
    '#default_value' => theme_get_setting('basic_breadcrumb_title'),
    '#description'   => t('Useful when the breadcrumb is not placed just before the title.'),
    '#suffix'        => '</div>', // #div-basic-breadcrumb
  );
  
  $form['options_settings']['wireframe_mode'] = array(
    '#type' => 'checkbox',
    '#title' =>  t('Wireframe Mode - Display borders around main layout elements'),
    '#description'   => t('<a href="!link">Wireframes</a> are useful when prototyping a website.', array('!link' => 'http://www.boxesandarrows.com/view/html_wireframes_and_prototypes_all_gain_and_no_pain')),
    '#default_value' => theme_get_setting('wireframe_mode'),
  );
  $form['options_settings']['clear_registry'] = array(
    '#type' => 'checkbox',
    '#title' =>  t('Rebuild theme registry on every page.'),
    '#description'   =>t('During theme development, it can be very useful to continuously <a href="!link">rebuild the theme registry</a>. WARNING: this is a huge performance penalty and must be turned off on production websites.', array('!link' => 'http://drupal.org/node/173880#theme-registry')),
    '#default_value' => theme_get_setting('clear_registry'),
  );
  
}