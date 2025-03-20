import { Controller } from "@hotwired/stimulus";

export default class extends Controller {

  connect() {
    console.log("Modal controller connected");
  }

  show(event) {
    event.preventDefault();
    const modalId = event.currentTarget.dataset.modalId;
    
    const popup = document.getElementById(modalId);
    if (popup) {
      popup.classList.remove("hidden");
    } else {
      console.log("Modal element not found!");
    }
  }

  hide(event) {
    console.log("Hide modal clicked");
    // Find the closest modal container
    const modal = event.target.closest("[data-controller='modal']");
    if (modal) {
      modal.classList.add("hidden");
    }
  }
}