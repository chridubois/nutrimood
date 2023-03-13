import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="moods-list"
export default class extends Controller {
  static targets = ["button"]

  connect() {
    console.log('coucou stimulus !')
  }
  buttonAppear() {
    console.log(this.buttonTarget)
    this.buttonTarget.removeAttribute("hidden")
  }
}
