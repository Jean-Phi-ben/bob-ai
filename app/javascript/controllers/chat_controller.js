import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["messages", "input", "button"]

  connect() {
    this.scrollBottom()
    this.resize()
  }

  scrollBottom() {
    if (!this.hasMessagesTarget) return
    const box = this.messagesTarget
    box.scrollTop = box.scrollHeight
  }

  resize() {
    if (!this.hasInputTarget) return
    const el = this.inputTarget
    el.style.height = "auto"
    el.style.height = el.scrollHeight + "px"
  }

  start() {
    // désactive le bouton pendant la requête
    if (this.hasButtonTarget) {
      this.buttonTarget.disabled = true
      this.buttonTarget.innerText = "Sending..."
    }
  }

  end() {
    // après réponse Turbo : réactive bouton, vide le champ, scroll bas
    if (this.hasButtonTarget) {
      this.buttonTarget.disabled = false
      this.buttonTarget.innerText = "Send"
    }
    if (this.hasInputTarget) {
      this.inputTarget.value = ""
      this.resize()
    }
    this.scrollBottom()
  }
}
