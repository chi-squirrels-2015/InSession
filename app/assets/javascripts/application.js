// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap.min
//= require_tree .
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
    
    console.log(duplicate);
  });

  // offset to demo blurring
  contentWrapper.scrollTop = 140;
});
