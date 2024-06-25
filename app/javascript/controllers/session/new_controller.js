import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="session--new"
export default class extends Controller {

  connect() {
    let password_button = document.getElementById('password_view');

    let password_field = document.getElementById('password');

    let x = "fa-regular fa-eye absolute inset-y-0 right-0 flex items-center mr-2 mb-auto mt-auto text-gray-500"
    let y = "fa-regular fa-eye-slash absolute inset-y-0 right-0 flex items-center mr-2 mb-auto mt-auto text-gray-500"


    let open = document.createElement('i');
    open.className = x;

    let close = document.createElement('i');
    close.className = y;

    password_button.addEventListener('click', function () {
      password_field.type = password_field.type === "password" ? "text" : "password";
      while (password_button.firstChild) {
        password_button.removeChild(password_button.firstChild);
      }
      if (password_field.type === "password") {
        password_button.appendChild(open);
      }
      else {
        password_button.appendChild(close);
      }
    })
  }
 }