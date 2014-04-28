/*jslint browser: true, indent: 2, plusplus: true, vars: true */

(function (window) {
  "use strict";

  var ahoy = window.ahoy;

  ahoy.track = function (name, properties) {
    ahoy.ready( function () {
      var data = {name: name, properties: properties};
      ahoy.log(data);

      // ensure JSON is defined
      if (typeof(JSON) !== "undefined") {
        $.ajax({
          type: "POST",
          url: "/ahoy/events",
          data: JSON.stringify(data),
          contentType: "application/json; charset=utf-8",
          dataType: "json"
        });
      }
    });
  };
}(window));
