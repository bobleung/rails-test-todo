import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="logclick"
export default class extends Controller {
  static values = { msg: String }

  log() {
    // This will log the value passed from the HTML
    console.log(this.msgValue)
  }
}
