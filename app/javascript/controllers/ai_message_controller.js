// app/javascript/controllers/ai_message_controller.js
import { Controller } from "stimulus"

export default class extends Controller {
  connect() {
    this.element.addEventListener("ajax:success", (event) => {
      const [data, _status, _xhr] = event.detail;
      const responseFrame = document.querySelector('#response_frame');
      responseFrame.innerHTML = data;
    });
  }
}
