import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="energy-list"
export default class extends Controller {
  static targets = ["item1", "item2", "item3", "item4", "button"]

  connect() {
    console.log('coucou c est stimulus !')
  }

  selectEnergy(event) {
    this.moodIdValue = event.params.level;
    console.log(this.moodIdValue);
    console.log(this.item1Target);
    this.item1Target.classList.remove("active")
    this.item2Target.classList.remove("active")
    this.item3Target.classList.remove("active")
    this.item4Target.classList.remove("active")
    switch (this.moodIdValue) {
      case 100:
        console.log("Case 100");
        this.item1Target.classList.add("active")
        this.item2Target.classList.add("active")
        this.item3Target.classList.add("active")
        this.item4Target.classList.add("active")
        document.getElementById("100").checked = true;
        break;
      case 75:
        console.log("Case 75");
        this.item2Target.classList.add("active")
        this.item3Target.classList.add("active")
        this.item4Target.classList.add("active")
        document.getElementById("75").checked = true;
        break;
      case 50:
        console.log("Case 50");
        this.item3Target.classList.add("active")
        this.item4Target.classList.add("active")
        document.getElementById("50").checked = true;
        break;
      case 25:
        console.log("Case 25");
        this.item4Target.classList.add("active")
        document.getElementById("25").checked = true;
        break;
    }
    this.buttonTarget.removeAttribute("hidden")
  }
}
