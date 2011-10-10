(function ($) {
  Drupal.behaviors.beauty03infield = {
    attach: function (context, settings) {
      // Add code here.
      $("label").inFieldLabels();
    }
  }
})(jQuery);