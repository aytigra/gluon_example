import Glue from "./glue"

const GlueGrid = {
  init() {
    let socket = Glue.Client.connect()
    let channel = Glue.Client.join(socket, "GlueGrid")

    channel.push("get", {})
      .receive("ok", payload => GlueGrid.render(payload))
      .receive("error", err => console.log("phoenix errored", err))
      .receive("timeout", () => console.log("timed out pushing"))

    channel.on("update", payload => {
      GlueGrid.render(payload.data)
    })
  },
  render(data) {
    let container = document.getElementById("glue-grid-table")

    while (container.firstChild) { container.removeChild(container.firstChild) }

    data.forEach(row => {
      let cell1 = document.createElement("div")
      cell1.innerText = row[0]
      container.appendChild(cell1)
      let cell2 = document.createElement("div")
      cell2.innerText = row[1]
      container.appendChild(cell2)
    });
  }
}

export default GlueGrid
