(function ($) {
  Drupal.behaviors.beauty04focus = {
    attach: function (context, settings) {
      var form_elements = '.form-text, textarea';
      $(form_elements).focus(function() {
        $(this).addClass('focused');
      });
      $(form_elements).blur(function() {
        $(this).removeClass('focused');
      });
    }
  }
})(jQuery);