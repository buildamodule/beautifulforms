(function ($) {
  Drupal.behaviors.beauty02infield = {
    attach: function (context, settings) {
      // Add code here.
      $("label").inFieldLabels();
    }
  }
})(jQuery);