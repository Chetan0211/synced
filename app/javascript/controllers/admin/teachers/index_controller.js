import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="admin--teachers--index"
export default class extends Controller {
  connect() {
    this.toggle_filter_menu()
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

  toggle_sort_buttons(target) {
    let asc_button_classes = "fa-solid fa-chevron-down text-white hover:!text-gray-200 h-4 w-4"    
    let desc_button_classes = "fa-solid fa-chevron-up text-white hover:!text-gray-200 h-4 w-4"

    let sort_elements = document.getElementsByClassName("sort")
    for (let element of sort_elements) {
      if (element == target) {
        element.dataset.direction = target.dataset.direction == 'asc' ? 'desc' : 'asc'
        if (element.dataset.direction == 'asc') {
          Array.from(element.children).forEach(x => element.removeChild(x))
          let asc_button = document.createElement("i")
          asc_button.className = asc_button_classes
          element.append(asc_button)
          
        } else {
          Array.from(element.children).forEach(x => element.removeChild(x))
          let desc_button = document.createElement("i")
          desc_button.className = desc_button_classes
          element.append(desc_button)
        }
      }
      else {
        Array.from(element.children).forEach(x => element.removeChild(x))
        let desc_button = document.createElement("i")
        desc_button.className = desc_button_classes
        element.append(desc_button)
        element.dataset.direction = 'desc'
      }
    }

  }

  sortTable(event) {
    event.preventDefault()
    let url = new URL(event.currentTarget.getAttribute('href'), window.location.origin)

    url.searchParams.set('sort', event.currentTarget.dataset.sort)
    url.searchParams.set('direction', event.currentTarget.dataset.direction)

    const csrfToken = document.querySelector('meta[name="csrf-token"]').content;
    this.toggle_sort_buttons(event.currentTarget)
    fetch(url.toString(), {
      headers: {
        'X-CSRF-Token': csrfToken
      },
      credentials: 'same-origin'
    })
    .then(response => response.text())
      .then(html => {
      console.log(html)
      document.getElementById('table_body').innerHTML = html
    })
    .catch(error => console.log('Error:', error));
  }
}
