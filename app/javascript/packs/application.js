// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "channels";

Rails.start();
Turbolinks.start();
ActiveStorage.start();

document.addEventListener("turbolinks:load", function () {
  var instrumentImage = document.querySelector(".instrument-image");

  function handleFileSelect(evt) {
    var files = evt.target.files; // FileList object

    // Loop through the FileList and render image files as thumbnails.
    for (var i = 0, f; (f = files[i]); i++) {
      // Only process image files.
      if (!f.type.match("image.*")) {
        continue;
      }

      var reader = new FileReader();

      // Closure to capture the file information.
      reader.onload = (function (theFile) {
        return function (e) {
          // Render thumbnail.
          var span = document.createElement("span");
          span.innerHTML = [
            '<img class="instrument-preview-thumb" src="',
            e.target.result,
            '" title="',
            escape(theFile.name),
            '"/>',
          ].join("");
          document.getElementById("list").insertBefore(span, null);
        };
      })(f);
      // Read in the image file as a data URL.
      reader.readAsDataURL(f);
    }
  }

  if (instrumentImage) {
    this.addEventListener("change", handleFileSelect, false);
  }
});
