import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="moods-list"
export default class extends Controller {
  static targets = ["btn", "item1"]

  connect() {
    console.log('coucou c est stimulus !')
  }

  btnAppear() {
    console.log('submit appear')
    this.btnTarget.removeAttribute("hidden")
  }

  selectAMood() {
    console.log('select a mood and only one')
    console.log(this.item1Targets)
  }
}
