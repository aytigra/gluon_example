import {Socket} from "phoenix"

const Glue = {}

Glue.Client = {
  connect() {
    let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
    let socket = new Socket("/socket", {params: {_csrf_token: csrfToken}})

    socket.connect()
    console.log("glue started", socket)

    return socket
  },
  join(socket, module_name) {
    let channel = socket.channel("glue:" + module_name, {})

    channel.join()
      .receive("ok", resp => { console.log("Joined successfully to " + module_name, resp) })
      .receive("error", resp => { console.log("Unable to join to" + module_name, resp) })

    return channel
  }
}

export default Glue
