import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="energy-list"
export default class extends Controller {
  static targets = ["item1", "item2", "item3", "item4", "button"]

  connect() {
    console.log('coucou c est stimulus !')
  }

  selectEnergy(event) {
    this.buttonTarget.removeAttribute("hidden")
  }
}
