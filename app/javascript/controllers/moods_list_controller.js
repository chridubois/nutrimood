import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="moods-list"
export default class extends Controller {
  static targets = ["btn", "item1", "checkbox", "emoticone"]
  static values = {
    url: String
  }

  connect() {
    console.log('coucou c est stimulus !')
    console.log(this.urlValue);
  }

  selectAMood(event) {
    const image = document.querySelector("#emoticone");
    const url = event.params["url"];
    this.btnTarget.removeAttribute("hidden")
    image.src = url;
    image.removeAttribute("hidden")
    if (this.checkboxTargets[event.params["idx"]].checked) {
      this.item1Targets[event.params["idx"]].classList.add("selected")
    }
    else {
     this.item1Targets[event.params["idx"]].classList.remove("selected")
    }

  }
}
