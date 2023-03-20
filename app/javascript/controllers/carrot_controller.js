import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="carrot"
export default class extends Controller {

  static targets = ["quantity"]

  connect() {
    console.log("stimulus miam")
    console.log(this.quantityTarget);
  }

  updateCarrotNumber() {

  }

  updateQuantity() {

  }

// ajouter une value stimulus "personn" (voir doc) =1
// action créée: personnValueChanged
// à chaque fois que change, incrémenter ou décrémenter
// + calculer ingrédients


}
