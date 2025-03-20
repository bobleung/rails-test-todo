// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
// import ModalController from "./modal_controller"; // Manually import modal controller

eagerLoadControllersFrom("controllers", application)
// application.register("modal", ModalController); // Ensure modal controller is explicitly registered

// Expose Stimulus for debugging in the console
// window.Stimulus = application;
