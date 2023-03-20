import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="carrot"
export default class extends Controller {

  static values = {
    number: Number
  }
  static targets = ["quantity", "btnMoins", "btnPlus", "btnCarrot"]

  connect() {
    console.log("stimulus carrot")
  }

  increase() {
    this.quantityTargets.forEach(element => {
      const qty = parseFloat(element.innerHTML);
      element.innerHTML = parseFloat(element.innerHTML) + qty/this.numberValue
    });
    this.numberValue += 1;
    this.btnCarrotTarget.innerHTML += `<i class="fa-solid fa-carrot fa-2x" id="carrot-${this.numberValue}"></i>`;
  }

  decrease() {
    if (this.numberValue > 1) {
      document.getElementById(`carrot-${this.numberValue}`).remove()
      this.quantityTargets.forEach(element => {
        const qty = parseFloat(element.innerHTML);
        element.innerHTML = parseFloat(element.innerHTML) - qty/this.numberValue
      });
      this.numberValue -= 1;
    }
  }
}
