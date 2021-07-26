import React from 'react'
import Gluon from '../gluon/core'
import UserGridContent from './user_grid_content'

class UserGrid extends React.Component {
  constructor(props) {
    super(props)

    let socket = Gluon.Client.connect()
    let channel = Gluon.Client.join(socket, "UserGrid")

    this.state = {socket: socket, channel: channel, users: [], attributes: {}}

    channel.on("update", payload => { this.set_data(payload.data) })
  }

  componentDidMount() {
    this.state.channel.push("data", {})
      .receive("ok", payload => this.set_data(payload))
      .receive("error", err => console.log("phoenix errored", err))
      .receive("timeout", () => console.log("timed out pushing"))
  }

  componentWillUnmount() {
    Gluon.Client.disconnect(this.state.socket)
  }

  set_data(payload) {
    this.setState({users: payload.data, attributes: payload.attributes})
  }

  render() {
    return <UserGridContent users={this.state.users} attributes={this.state.attributes}/>
  }
}

export default UserGrid
