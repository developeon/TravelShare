  $('.file-upload').hide();
  $('#file-upload1').show();

 /*  $('.reveal-file').click(function(event) {
    $('#file-upload2').show();
    $(this).click(function(event) {
      $('#file-upload3').show();
      $(this).hide();
    });
  });*/

$("#contact_image_1").on('change',function(){
     $('#file-upload2').show();
});

$("#contact_image_2").on('change',function(){
     $('#file-upload3').show();
});
$("#contact_image_3").on('change',function(){
    $('#file-upload4').show();
});
$("#contact_image_4").on('change',function(){
    $('#file-upload5').show();
});

$('.image-box').click(function(event) {
  var imgg = $(this).children('img');
  $(this).siblings().children("input").trigger('click');  

  $(this).siblings().children("input").change(function() {
    var reader = new FileReader();

    reader.onload = function (e) {
      var urll = e.target.result;
      $(imgg).attr('src', urll);
      imgg.parent().css('background','transparent');
			imgg.show();
      imgg.siblings('p').hide();
			
    }
    reader.readAsDataURL(this.files[0]);
  }); 
});
