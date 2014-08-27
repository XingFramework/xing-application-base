
function transform_or_load_image(elem) {
  $image = $(elem);
  $text = $image.parents("tr").find(".dimensions");
  console.log('running transform');
  if ($image.width() == 0) {
    $image.load(transform_or_load_image)
  }
  $text.append($image.width() + " x " + $image.height());
}

Ninja.behavior({
  'body.admin.images.show tr.uploaded_image img': {
    transform: transform_or_load_image,
    //events: { load: load_image }
   },
  'body.admin.images.show.with_admin div.arrow-right': {
    click: function(evnt, elem) {
      evnt.preventDefault();

      var $elem = $(elem);
      // Selects the div containing the image
      var $sibling = $elem.siblings("div").eq(1);

      $elem.toggleClass("arrow-right arrow-down");
      $sibling.toggleClass("image-partial image-full");
    }
  },
  'body.admin.images.show.with_admin button.my_clip_button': {
    transform: function(elem) {

      var $elem = $(elem);
      var $clip = new ZeroClipboard($elem);

    }
  },
  'body.admin.images.show.with_admin input': {
    click: function(evnt, elem) {
      evnt.preventDefault();

      var $elem = $(elem);

      $elem.select();

    }
  },
  'body.admin.images.show.with_admin img': {
    transform: function(elem) {

      var $elem = $(elem);
      var $arrow = $elem.parents("div.image-partial").siblings("div.arrow-right");

      if ($elem.height() <= 80) {
        $arrow.css("display", "none");
        $elem.css("margin-left", "40px");
      }
    }
  },
});
