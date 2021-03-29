Spree.prepareTaxonImageUploader = function () {
  var uploadZone = document.getElementById('taxon-upload-zone');
  if(!uploadZone) return;
  
  // Kick off by binding the events on the upload zone
  var imageUploads = new Backbone.Collection();
  var progressZone = document.getElementById('progress-zone');
  var variantId = document.querySelector('input[name="taxon_image[viewable_id]"]').value;
  
  new Spree.Views.Images.UploadZone({
    el: uploadZone,
    collection: imageUploads
  });
  
  imageUploads.on('add', function(progressModel) {
    progressModel.set({variant_id: variantId});
    
    var progressView = new Spree.Views.Images.UploadProgress({model: progressModel});
    progressZone.appendChild(progressView.render().el);
  });
};

Spree.ready(function() {
  $('#new_image_link').click(function(event) {
    event.preventDefault();
    
    $(this).hide();
    $('#new_image').show();
  });
  
  Spree.prepareTaxonImageUploader();
});
