import { Controller } from "@hotwired/stimulus"
import $ from "jquery"
import 'selectize/dist/js/selectize.min.js';

// Connects to data-controller="selectize"
export default class extends Controller {
  connect() {
    $('.selectize').selectize({
      create: function(input, callback) {
        // console.log(input);
        const url = `${location.origin}/hashtags`
        /* HERE */
        const body = {hashtag: {"title": input}}
        const csrfToken = document.querySelector("[name='csrf-token']").content

        fetch(url, {
          method: "POST",
          headers: {
            "X-CSRF-Token": csrfToken,
            "Content-Type": "application/json",
          },
          body: JSON.stringify(body)
        })
          .then(response => response.json())
          .then((data) => {
            console.log(data)
            callback({value: data.id, text: data.title});
          })
      }
    });
  }
}
