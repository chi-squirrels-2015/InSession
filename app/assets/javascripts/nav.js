$( document ).ready(function() {
  var content = document.querySelector('.content');
  var duplicate = content.cloneNode(true);
  var contentBlurred = document.createElement('div');
  contentBlurred.className = 'content-blurred';
  contentBlurred.appendChild(duplicate);

  var header = document.querySelector('header');
  header.appendChild(contentBlurred);

  var contentWrapper = document.querySelector('.content-wrapper'),
  translation;

  contentWrapper.addEventListener('scroll',function(){
    translation = 'translate3d(0,' + (-this.scrollTop + 'px') + ',0)';
    duplicate.style['-webkit-transform'] = translation;
    duplicate.style['-moz-transform'] = translation;
    duplicate.style['transform'] = translation;
  });

  contentWrapper.scrollTop = 1;

  $("#menu-button").on("click", function(){
    if ( $("header").height() === 90 ){
      $("header").css("height","300px");
    } else {
      $("header").css("height","90px");
    }
  });
});


