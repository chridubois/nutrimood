import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="moods-list"
export default class extends Controller {
  static targets = ["btn", "item1", "checkbox"]

  connect() {
    console.log('coucou c est stimulus !')
  }

  selectAMood(event) {
    console.log('submit appear')
    this.btnTarget.removeAttribute("hidden")

    console.log('select a mood and only one')
    console.log(this.checkboxTargets[event.params["idx"]].checked)

    if (this.checkboxTargets[event.params["idx"]].checked) {
      this.item1Targets[event.params["idx"]].classList.add("selected")
    }

    else {
     this.item1Targets[event.params["idx"]].classList.remove("selected")
    }

  }
}
