import Gluon from '../gluon/core'
import React from 'react'

class UserInfo extends React.PureComponent {
  constructor(props) {
    super(props)

    let socket = Gluon.Client.connect()
    let channel = Gluon.Client.join(socket, "UserInfo")

    this.state = {
      socket: socket,
      channel: channel,
      user: null
    }
  }

  componentDidMount() {
    this.state.channel.on("data_changed", payload => { this.setState({user: payload.data}) })
    this.fetchData(this.props.user_id)
  }

  componentDidUpdate(prevProps) {
    if (this.props.user_id !== prevProps.user_id) {
      this.fetchData(this.props.user_id);
    }
  }

  fetchData(user_id) {
    this.state.channel.push("data", {id: user_id })
      .receive("ok", payload => { this.setState({user: payload}) })
      .receive("error", err => { console.log("phoenix errored", err)})
      .receive("timeout", () => { console.log("timed out pushing")})
  }

  componentWillUnmount() {
    Gluon.Client.disconnect(this.state.socket)
  }


  render() {
    let info

    if (this.state.user) {
      info = <div>
        <div>{this.state.user.id}</div>
        <div className="font-bold text-lg">{this.state.user.email}</div>
      </div>
    } else {
      info = <div>
        <div>Select user.</div>
      </div>
    }

    return (
      <div className="text-center p-8">
        {info}
      </div>
    )
  }
}

export default UserInfo
