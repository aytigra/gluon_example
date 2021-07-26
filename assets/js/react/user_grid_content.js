import React from 'react'

class UserGridContent extends React.Component {
  constructor(props) {
    super(props)

    this.state = {modal_shown: false}
  }

  render() {
    const rows = this.props.users.map((user) =>
      <tr key={user.id}>
        <td>{user.id}</td>
        <td>{user.email}</td>
      </tr>
    )

    return <div>
      <h1>User Grid</h1>
      <table>
        <thead><tr><td>ID</td><td>Email</td></tr></thead>
        <tbody>{rows}</tbody>
      </table>
    </div>
  }
}

export default UserGridContent
