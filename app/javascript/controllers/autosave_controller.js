import { Controller } from '@hotwired/stimulus'
import { ApplicationController, useDebounce } from 'stimulus-use'

export default class extends Controller {
  static targets = [ 'form' ]
  static values = { delay: Number }
  static debounces = [ 'save' ]

  connect() {
    useDebounce(this, { wait: this.delayValue })
  }

  save() {
    // console.log(this.delayValue, this.formTarget)
    this.formTarget.requestSubmit()
  }
}
