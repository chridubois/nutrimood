import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="symptoms-list"
export default class extends Controller {
  static targets = ["item", "button"]
  connect() {
    console.log("Hello from our first Stimulus controller")

  }

  symptomChosen(event) {
    console.log(this.itemTargets[event.params["index"]]);
    console.log('this.itemTarget?');
    this.itemTargets[event.params["index"]].classList.add("selected")
  }

  buttonAppear() {
    this.buttonTarget.setAttribute("value", "Aidez-moi !")
  }
}
