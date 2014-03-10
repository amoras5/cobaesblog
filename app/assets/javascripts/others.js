//Ocultar y Mostrar formulario de respuesta a microposts.
function evento(){
  $(".toggle")
    .live('click', function(){
      if ($(this).next().is(":hidden")) {
        $(this).next().slideDown("fast");
      } else {
        $(this).next().hide();
      }
    });
}
$(document).ready(evento);

//Pie de página formulario micropost para indicar límite máximo de caracteres.
function postext(){
  $(".postext").inputlimiter({
    limit: 500,
    remText: '%n caractere%s restantes.',
    limitText: 'Campo limitado a %n caractere%s.'
  });
}
$(document).ready(postext);

//Limpiar search bar cuando se da click en botón quitar filtros.
function clear_search_bar() {
  document.forms["searchbar"]["search"].value = "";
}

//tooltip 
$(function(){
  $('.enviado_a').tooltip({
    selector: "a[rel=tooltip]"
  });
  $('.enviado_a').live('click', function(){
    micid = $(this).attr('id');
    if($('a#article').attr('id') == 'article'){
      $('#aver').load('/articles/listArticleaddressees?micid=' + micid + ' #tabla');
    } else {
      $('#aver').load('/microposts/listMicropostaddressees?micid=' + micid + ' #tabla');
    }
  });
}); // end function

// cuando se da click en el link de pendiente del micropost
function pendiente(){
    $('a.pendiente').live('click', function(){
        if ($(this).text() == " | pendiente"){
          $(this).text(" | enterado");
          $(this).css({color: '#51a351'});
          $(this).removeClass('pendiente');
          $(this).hide();
          refrescar();
        }
    });
}
$(document).ready(pendiente);

// news animation
function newsAnimation(){
  if ($('.news').is(":visible")){
    var audio = document.getElementById("sonido");
    audio.play(); // bouncing sound.
    $('.news p')
      .animate({
        opacity: 1
      },
      1500
      ); // end fadeIn text
    $('.news img')
      .animate({
        top: '10px'
      },
      1100,
      'easeOutBounce'
    ); // end image animation
  } // end if div is visible
} // end function.

$(document).ready(newsAnimation);