import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="admin--teachers--index"
export default class extends Controller {
  connect() {
    this.table_visible()
    this.toggle_filter_menu()
  }

  // This method is used to toggle the table visibility based on the presence of data in the table body
  table_visible() {
    var teachers_table = document.getElementById("teachers_table")
    var empty_table = document.getElementById("empty_table")
    var table_body = document.getElementById('table_body').innerHTML
    if (table_body && table_body.trim().length > 0) {
      if(teachers_table.classList.contains("hidden")) {
        teachers_table.classList.remove("hidden")
      }
      if(!empty_table.classList.contains("hidden")) {
        empty_table.classList.add("hidden")
      }
    }
    else {
      if(!teachers_table.classList.contains("hidden")) {
        teachers_table.classList.add("hidden")
      }
      if(empty_table.classList.contains("hidden")) {
        empty_table.classList.remove("hidden")
      }
    }
    
  }

  // This method is used to toggle the filter menu when clicked on filter button
  toggle_filter_menu() {
    let filter_button = document.getElementById("filter")
    let filter_menu = document.getElementById("filter_menu")
    filter_button.addEventListener("click", (button) => {
      button.preventDefault();
      filter_menu.classList.toggle("hidden")
      if (filter_menu.classList.contains("hidden")) {
        filter_menu.classList.remove('show')
      }
      else {
        filter_menu.classList.add('show')
      }
    })
  }

  // This method is used to hide the filter menu
  filter_menu_hide() {
    let filter_menu = document.getElementById("filter_menu")
    if (!filter_menu.classList.contains("hidden")) {
      filter_menu.classList.add("hidden")
      filter_menu.classList.remove('show')
    }
  }

  // This method is used to toggle the buttons of the sort
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
    var filter_form = document.getElementById("filter_form")
    var start_date = document.getElementById("filter_start_date").value
    var end_date = document.getElementById("filter_end_date").value
    var search_text = document.getElementById("search_text").value
    var checkbox = filter_form.querySelectorAll('[id^="status_"]')
    var status = []
    checkbox.forEach(x => {
      if (x.checked) {
        status.push(x.defaultValue)
      }
    })

    let url = new URL(event.currentTarget.dataset.href, window.location.origin)
    if (event.currentTarget.dataset.sort != undefined && event.currentTarget.dataset.direction != undefined) {
      url.searchParams.set('sort', event.currentTarget.dataset.sort)
      url.searchParams.set('direction', event.currentTarget.dataset.direction)
      this.toggle_sort_buttons(event.currentTarget)
    }
    
    if (start_date != "" && end_date != "") {
      url.searchParams.set('start_date', start_date)
      url.searchParams.set('end_date', end_date)
    }
    if (status.length > 0) { 
      url.searchParams.set('status', JSON.stringify(status))
    }
    if(search_text && search_text.trim().length > 0) {
      url.searchParams.set('search_text', search_text)
    }

    this.filter_menu_hide()

    const csrfToken = document.querySelector('meta[name="csrf-token"]').content;
    
    fetch(url.toString(), {
      headers: {
        'X-CSRF-Token': csrfToken,
        'X-Requested-With': 'XMLHttpRequest'
      },
      credentials: 'same-origin'
    })
    .then(response => response.text())
    .then(data => {
      var output = JSON.parse(data)
      document.getElementById('table_body').innerHTML = output.teachers
      document.getElementById('pagination').innerHTML = output.pagination
      this.table_visible()
    })
    .catch(error => console.log('Error:', error));
  }

  clearFilter(event) {
    event.preventDefault()
    var start_date_field = document.getElementById("filter_start_date")
    var end_date_field = document.getElementById("filter_end_date")
    var checkbox_fields = filter_form.querySelectorAll('[id^="status_"]')
    var search_text_field = document.getElementById("search_text")
    start_date_field.value = ''
    end_date_field.value = ''
    search_text_field.value = ''
    checkbox_fields.forEach(x => x.checked = false)
    this.filter_menu_hide()
    this.sortTable(event)
  }
}
