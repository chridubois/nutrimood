
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  connect() {
    console.log("Hello from our first Stimulus controller")
  }

  batteryChosen() {
    console.log('item !!!');
    this.itemTarget.classList.add("selected")
  }

  buttonAppear() {
    this.buttonTarget.removeAttribute("hidden")
  }

}
