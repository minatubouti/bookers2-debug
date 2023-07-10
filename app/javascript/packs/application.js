// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import $ from "jquery"
// jQueryを呼び出し
window.$ = window.jQuery = $
import "popper.js"
import "bootstrap"

import Raty from "../raty"

window.raty = function(elem,opt) {
  let raty =  new Raty(elem,opt)
  raty.init();
  return raty;
}

import "../stylesheets/application" 

document.addEventListener('turbolinks:load', () => {
  $('#rating').raty({
    path: '/assets/',
    scoreName: 'book[rating]'
  });

  $('#display-rating').raty({
    path: '/assets/',
    readOnly: true,
    score: function() {
      return $(this).attr('data-score');
    }
  });
});


Rails.start()
Turbolinks.start()
ActiveStorage.start()
