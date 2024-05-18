import { ApplicationController, useDebounce } from "stimulus-use"

export default class extends ApplicationController {
  static debounces = ['submit']

  connect() {
    useDebounce(this, { wait: 1000 })
  }

  submit () {
    this.element.requestSubmit()
  }
}
