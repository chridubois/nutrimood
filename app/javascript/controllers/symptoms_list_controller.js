import { Controller } from "@hotwired/stimulus"
import { end } from "@popperjs/core";

// Connects to data-controller="symptoms-list"
export default class extends Controller {
  static targets = ["item", "button", "checkbox"]

  connect() {
    console.log("Hello from our first Stimulus controller")
  }

  symptomChosen(event) {
    console.log(this.checkboxTargets[event.params["index"]].checked)
    console.log(this.checkboxTargets[event.params["index"]])

// changement bouton submit
    this.buttonTarget.setAttribute("value", "Aidez-moi !")
// modif scss quand selection
    if (this.checkboxTargets[event.params["index"]].checked)
      this.itemTargets[event.params["index"]].classList.add("selected")
    else
      this.itemTargets[event.params["index"]].classList.remove("selected")
    end
  }

}
