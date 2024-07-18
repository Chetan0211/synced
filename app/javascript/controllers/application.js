import { Application } from "@hotwired/stimulus"
import SortController from "controllers/admin/teachers/sort_controller"

const application = Application.start()
application.register("sorting", SortController)

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
