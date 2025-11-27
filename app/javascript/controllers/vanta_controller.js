import { Controller } from "@hotwired/stimulus"

const scriptCache = {}

const loadScript = (src) => {
  if (scriptCache[src]) return scriptCache[src]
  scriptCache[src] = new Promise((resolve, reject) => {
    if (document.querySelector(`script[src="${src}"]`)) {
      resolve()
      return
    }
    const script = document.createElement("script")
    script.src = src
    script.async = true
    script.onload = resolve
    script.onerror = () => reject(new Error(`Erreur chargement ${src}`))
    document.head.appendChild(script)
  })
  return scriptCache[src]
}

export default class extends Controller {
  connect() {
    this.initVanta()
  }

  disconnect() {
    this.destroyVanta()
  }

  async initVanta() {
    try {
      await Promise.all([
        loadScript("https://cdnjs.cloudflare.com/ajax/libs/three.js/r121/three.min.js"),
        loadScript("https://cdn.jsdelivr.net/npm/vanta@latest/dist/vanta.globe.min.js")
      ])
    } catch (err) {
      console.warn("Impossible de charger Vanta", err)
      return
    }

    this.startVanta()
  }

  startVanta() {
    if (!window.VANTA || !window.VANTA.GLOBE) return
    if (this.vantaBackground) this.vantaBackground.destroy()
    this.vantaBackground = window.VANTA.GLOBE({
      el: this.element,
      mouseControls: true,
      touchControls: true,
      gyroControls: false,
      minHeight: 200,
      minWidth: 200,
      scale: 1,
      scaleMobile: 1
    })
  }

  destroyVanta() {
    if (this.vantaBackground) {
      this.vantaBackground.destroy()
      this.vantaBackground = null
    }
  }
}
