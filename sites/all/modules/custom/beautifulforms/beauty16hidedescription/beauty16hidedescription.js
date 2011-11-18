(function ($) {
  Drupal.behaviors.beauty04focus = {
    attach: function (context, settings) {
      
      // Show when clicked.
      $('.form-item').click(function () {
        $('.description').hide();
        $(this).find('.description').show();
      });
      
      // Hide when blurred.
      $('input, textarea').blur(function () {
        $('.description').hide();
      });
      
      // Show when tabbed over to.
      $('input, textarea').focus(function () {
        $('.description').hide();
        $(this).parents('.form-item').find('.description').show();
      });
      
    }
  }
})(jQuery);