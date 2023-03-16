import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="moods-list"
export default class extends Controller {
  static targets = ["btn", "item1", "input", "emoticone"]
  static values = {
    moodId: {
      type: Number, default: 0
    },
    urls: Array
  }

  connect() {
    console.log('coucou c est stimulus !')
    console.log(this.urlsValue);
  }

  selectAMood(event) {
    this.moodIdValue = event.params.idx;
  }

  moodIdValueChanged(value, previousValue) {
    if (this.moodIdValue) {
      const url = this.urlsValue.filter((m) => m.id === value)[0].url;
      this.emoticoneTarget.src = url;
      this.emoticoneTarget.removeAttribute("hidden")
      this.btnTarget.removeAttribute("hidden")
      previousValue && this.item1Targets.filter((m) => Number(m.dataset.moodsListIdxParam) === previousValue)[0].classList.remove('selected')
      value && this.item1Targets.filter((m) => Number(m.dataset.moodsListIdxParam) === value)[0].classList.add('selected');
      this.inputTarget.value = value;
    }
  }
}
