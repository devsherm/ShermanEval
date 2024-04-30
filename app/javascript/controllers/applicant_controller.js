// app/javascript/controllers/applicant_controller.js

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  validate(event) {
    const input = event.target
    const isValid = input.checkValidity()

    input.classList.toggle("border-red-500", !isValid)
    input.classList.toggle("border-green-500", isValid)
  }
}
