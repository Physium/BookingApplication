// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

import "bootstrap"
import "@fortawesome/fontawesome-free/js/all"
require("moment/locale/ja")
require("tempusdominus-bootstrap-4")
require('datatables.net-bs4')
import "datatables.net-bs4/css/dataTables.bootstrap4.css";

//jquery stuff just to get datatables working.
import $ from 'jquery';
global.$ = jQuery;

var userDataTable;
var roomDataTable;

//figure out what is this turbolink stuff. causing alot of issues.
$(document).on('turbolinks:load', function(){
    userDataTable = $('#users-dtable').DataTable();
    roomDataTable = $('#room-dtable').DataTable();
});

document.addEventListener("turbolinks:before-cache", function() {
    userDataTable.destroy();
    roomDataTable.destroy();
  });

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
