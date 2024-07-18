import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="admin--teachers--sort"
export default class extends Controller {
  connect() {
    this.element.addEventListener('ajax:success', this.updateTable.bind(this))
  }

  updateTable(event) {
    console.log(event.detail)
    const [data, status, xhr] = event.detail
    document.getElementById('table_body').innerHTML = xhr.response
  }
}
