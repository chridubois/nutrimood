import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="symptoms-list"
export default class extends Controller {
  static targets = ["item", "button"]
  connect() {
    console.log("Hello from our first Stimulus controller")
  }

  symptomChosen() {
    console.log('item !!!');
    this.itemTarget.classList.add("selected")
  }

  buttonAppear() {
    this.buttonTarget.removeAttribute("hidden")
  }
}
