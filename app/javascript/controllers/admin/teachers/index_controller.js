import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="admin--teachers--index"
export default class extends Controller {
  connect() {
    this.toggle_filter_menu()
    this.element.addEventListener('ajax:success', this.updateTable.bind(this))
  }

  updateTable(event) {
    console.log(event.detail)
    const [data, status, xhr] = event.detail
    document.getElementById('table_body').innerHTML = xhr.response
  }

  toggle_filter_menu() {
    let filter_button = document.getElementById("filter")
    let filter_menu = document.getElementById("filter_menu")
    filter_button.addEventListener("click", (button) => {
      button.preventDefault();
      filter_menu.classList.toggle("hidden")
      if (filter_menu.classList.contains("hidden")) {
        filter_menu.classList.remove("show")
        filter_menu.classList.add("hide")
      } else {
        filter_menu.classList.remove("hide")
        filter_menu.classList.add("show")
      }
    })
  }
}
