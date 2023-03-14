import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="energy-list"
export default class extends Controller {
  static targets = ["item1", "item2", "item3", "item4", "button"]

  connect() {
    console.log('coucou c est stimulus !')
  }

  selectEnergy(event) {
    console.log('submit appear')
    this.buttonTarget.removeAttribute("hidden")

    console.log('select a mood and only one')
    console.log(this.checkboxTargets[event.params["idx"]].checked)

    switch (expr) {
      case 'Oranges':
        console.log('Oranges are $0.59 a pound.');
        break;
      case 'Mangoes':
      case 'Papayas':
        console.log('Mangoes and papayas are $2.79 a pound.');
        // Expected output: "Mangoes and papayas are $2.79 a pound."
        break;
      default:
        console.log(`Sorry, we are out of ${expr}.`);
    }

  }
}
