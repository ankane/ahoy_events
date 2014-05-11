/*jslint browser: true, indent: 2, plusplus: true, vars: true */

(function (window) {
  "use strict";

  var ahoy = window.ahoy;
  var canStringify = typeof(JSON) !== "undefined" && typeof(JSON.stringify) !== "undefined";
  var eventQueue = [];

  // https://github.com/klughammer/node-randomstring
  function generateId() {
    var chars = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghiklmnopqrstuvwxyz';
    var length = 32;
    var string = '';

    for (var i = 0; i < length; i++) {
      var randomNumber = Math.floor(Math.random() * chars.length);
      string += chars.substring(randomNumber, randomNumber + 1);
    }

    return string;
  }

  function saveEventQueue() {
    // TODO add stringify method for IE 7 and under
    if (canStringify) {
      ahoy.setCookie("ahoy_events", JSON.stringify(eventQueue), 1);
    }
  }

  function trackEvent(event) {
    ahoy.ready( function () {
      // ensure JSON is defined
      if (canStringify) {
        $.ajax({
          type: "POST",
          url: "/ahoy/events",
          data: JSON.stringify(event),
          contentType: "application/json; charset=utf-8",
          dataType: "json",
          success: function() {
            // remove from queue
            for (var i = 0; i < eventQueue.length; i++) {
              if (eventQueue[i].id == event.id) {
                eventQueue.splice(i, 1);
                break;
              }
            }
            saveEventQueue();
          }
        });
      }
    });
  }

  ahoy.track = function (name, properties) {
    // generate unique id
    var event = {
      id: generateId(),
      name: name,
      properties: properties,
      time: (new Date()).getTime() / 1000.0
    };
    ahoy.log(event);

    eventQueue.push(event);
    saveEventQueue();

    // wait in case navigating to reduce duplicate events
    setTimeout( function() {
      trackEvent(event);
    }, 1000);
  };

  ahoy.trackView = function() {
    var properties = {
      url: window.location.href,
      title: document.title
    };
    ahoy.track("$view", properties);
  };

  ahoy.trackClicks = function() {
    $(document).on("click", "a, button, input[type=submit]", function(e) {
      var $target = $(e.currentTarget);
      var tag = $target.get(0).tagName.toLowerCase();
      var text = tag == "input" ? $target.val() : $.trim($target.text());
      var properties = {
        tag: tag,
        id: $target.attr("id"),
        class: $target.attr("class"),
        text: text,
        href: $target.attr("href")
      };
      ahoy.track("$click", properties);
    });
  };

  ahoy.trackAll = function() {
    ahoy.trackView();
    ahoy.trackClicks();
  };

  // push events from queue
  try {
    eventQueue = JSON.parse(ahoy.getCookie("ahoy_events") || "[]");
  } catch (e) {
    // do nothing
  }

  for (var i = 0; i < eventQueue.length; i++) {
    trackEvent(eventQueue[i]);
  }
}(window));
