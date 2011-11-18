<?php

function sass_settings_form() {
  $form = array();
  
  $form['sass_development_mode'] = array(
    '#type' => 'checkbox',
    '#title' => t('Development Mode'),
    '#description' => t('Enable development mode. All CSS files with corresponding SCSS/SASS files will be rebuilt on each request.'),
    '#default_value' => variable_get('sass_development_mode', true),
  );

  $form['sass_show_development_mode_warning'] = array(
    '#type' => 'checkbox',
    '#title' => t('Show development mode warning'),
    '#description' => t('Uncheck this to stop showing the warning about being in development mode.'),
    '#default_value' => variable_get('sass_show_development_mode_warning', true),
  );

  $form = system_settings_form($form);

  return $form;
}
