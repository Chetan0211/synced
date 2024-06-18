import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="signing--new"
export default class extends Controller {
  connect() {
    let password_button = document.getElementById('password_view');
    let confirm_password_button = document.getElementById('confirm_password_view');

    let password_field = document.getElementById('password');
    let confirm_password_field = document.getElementById('confirm_password');
    let email_identifier_field = document.getElementById('email_identifier');

    let email_identifier_label = document.getElementById('identifier');

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


    confirm_password_button.addEventListener('click', function () {
      confirm_password_field.type = confirm_password_field.type === "password" ? "text" : "password";
      while (confirm_password_button.firstChild) {
        confirm_password_button.removeChild(confirm_password_button.firstChild);
      }
      if (confirm_password_field.type === "password") {
        confirm_password_button.appendChild(open);
      }
      else {
        confirm_password_button.appendChild(close);
      }
    });

    email_identifier_field.addEventListener('blur', function () {
      if(email_identifier_field.value === null || email_identifier_field.value.trim() === "") {
        email_identifier_label.innerText = "@example.com";
      }
      else {
        email_identifier_label.innerText = "@"+email_identifier_field.value;
      }
      
    })
  }
}
