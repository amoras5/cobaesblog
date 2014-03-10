var intervaloId = null;
function refrescar(){
  var numItems = $('div.hiddenDiv:visible').size();
  if (numItems == 0){
	  $("#articlesfeed").load(location.href+" #articlesfeed>*", "");
  }
  $.ajaxSetup({ cache: false, async: false });
  $.ajax('/microposts/countNews')
    .done(function(data) {
      if (data == '00'){
        $('.news').hide();
      } else {
        if ('div.news:hidden'){$('.news').show();}
        $('.news img').attr("src", "/images/"+ data + ".png");
      } // end if
  });
  $('.enviado_a').tooltip({
    selector: "a[rel=tooltip]"
  });
}
intervaloId = setInterval(refrescar, 1500000);