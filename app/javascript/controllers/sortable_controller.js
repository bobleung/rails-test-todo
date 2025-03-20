import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"

export default class extends Controller {
  static targets = ["item"]
  static values = {
    url: String,
    resourceName: String
  }

  connect() {
    this.sortable = new Sortable(this.element, {
      animation: 150,
      ghostClass: "sortable-ghost",
      dragClass: "sortable-drag",
      handle: ".drag-handle",
      onEnd: this.end.bind(this)
    })
  }

  end(event) {
    const id = event.item.dataset.id
    const newIndex = event.newIndex
    
    // Create an array of all item IDs in their current order
    const itemIds = Array.from(this.itemTargets).map(item => item.dataset.id)
    
    // Send the new order to the server
    fetch(this.urlValue, {
      method: 'PATCH',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify({
        [this.resourceNameValue]: {
          id: id,
          position: newIndex + 1,
          ordered_ids: itemIds
        }
      })
    })
    .catch(error => {
      console.error('Error:', error)
    })
  }
}