// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)


import { Application } from "@hotwired/stimulus"
import ChatController from "./chat_controller"

const application = Application.start()
application.register("chat", ChatController)


import MiniChatController from "./mini_chat_controller"
application.register("mini-chat", MiniChatController)
