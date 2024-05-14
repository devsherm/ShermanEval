import { Controller } from "@hotwired/stimulus";

export default class extends Controller {

  static targets = ["alert"]

  connect() {
    const timeout = this.alertTarget.dataset.timeout

    setTimeout(() => {
      this.alertTarget.remove()
    }, timeout)

    this.alertTarget.addEventListener("click", () => {
      this.alertTarget.remove()
    })
  }
}
