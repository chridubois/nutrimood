import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="moods-list"
export default class extends Controller {
  connect() {
    console.log('coucou stimulus !')
  }
  buttonAppear() {
    this.buttonTarget.removeAttribute("hidden")
  }
}
