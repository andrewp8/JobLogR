// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

import "@hotwired/turbo-rails"
import "controllers"
import "chartkick";
import "Chart.bundle";
import "trix"
import "@rails/actiontext"


// document.addEventListener('DOMContentLoaded', function() {
//   var buttonRow = document.querySelector('.trix-button-row');
//   if (buttonRow) {
//       buttonRow.style.backgroundColor = 'red'; // Change the background color to red
//   }
// });


document.addEventListener('DOMContentLoaded', function() {
  // Find the <trix-toolbar> element within the modal
  var trixToolbar = document.querySelector('#emailModal .trix-button-row');
  var buttonsToHide = document.querySelectorAll('.trix-button[data-trix-action="decreaseNestingLevel"], .trix-button[data-trix-action="increaseNestingLevel"], .trix-button[data-trix-action="attachFiles"], .trix-button[data-trix-action="undo"], .trix-button[data-trix-action="redo"]');

  if (trixToolbar) {
    // Traverse child elements (buttons) and add Bootstrap button classes
    trixToolbar.querySelectorAll('.trix-button').forEach(function(button) {
      button.classList.add('btn', 'btn-dark');
    });
    trixToolbar.classList.add('flex-container');
  }
  buttonsToHide.forEach(function(button) {
    button.style.display = 'none';
  });
});
