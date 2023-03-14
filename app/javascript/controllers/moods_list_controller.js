import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="moods-list"
export default class extends Controller {
  static targets = ["btn", "item1", "checkbox"]

  connect() {
    console.log('coucou c est stimulus !')
  }

  selectAMood(event) {
    this.btnTarget.removeAttribute("hidden")
    if (this.checkboxTargets[event.params["idx"]].checked) {
      this.item1Targets[event.params["idx"]].classList.add("selected")
    }
    else {
     this.item1Targets[event.params["idx"]].classList.remove("selected")
    }

  }
}
