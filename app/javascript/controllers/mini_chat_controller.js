// app/javascript/controllers/mini_chat_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["messages", "input", "button"]

  connect() {
    console.log("MiniChatController connecté ✅")
  }

  send() {
    console.log("click -> mini-chat#send appelé ✅")

    const text = this.inputTarget.value.trim()
    if (text.length === 0) return

    this.appendUser(text)
    this.inputTarget.value = ""

    this.buttonTarget.disabled = true
    this.buttonTarget.innerText = "Thinking..."

    fetch("/ai/assist", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector("[name='csrf-token']").content
      },
      body: JSON.stringify({ prompt: text })
    })
      .then(res => res.json())
      .then(data => {
        console.log("Réponse IA ✅", data)
        this.appendAi(data.reply)
      })
      .catch((err) => {
        console.error("Erreur IA ❌", err)
        this.appendAi("Sorry, I couldn't answer right now.")
      })
      .finally(() => {
        this.buttonTarget.disabled = false
        this.buttonTarget.innerText = "Send"
      })
  }

  appendUser(text) {
    this.messagesTarget.insertAdjacentHTML(
      "beforeend",
      `<div class="mb-2 text-end">
        <div class="d-inline-block p-2 rounded text-white"
             style="max-width:75%; background:#6366F1;">
          ${text}
        </div>
      </div>`
    )
    this.scroll()
  }

  appendAi(text) {
    this.messagesTarget.insertAdjacentHTML(
      "beforeend",
      `<div class="mb-2">
        <div class="d-inline-block p-2 rounded bg-white border"
             style="max-width:75%;">
          ${text}
        </div>
      </div>`
    )
    this.scroll()
  }

  scroll() {
    this.messagesTarget.scrollTop = this.messagesTarget.scrollHeight
  }
}
