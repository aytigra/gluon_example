import React from 'react'
import UserGrid from './user_grid'
import UserInfo from './user_info'

class App extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      user_id: null
    }

    this.handleUserSelected = this.handleUserSelected.bind(this)
  }

  handleUserSelected(user_id) {
    console.log(user_id)
    this.setState({user_id: user_id})
  }

  render() {
    return <div className="h-full flex flex-col">
      <h1 className="text-center">This is Gluon!</h1>
      <div className="flex-grow grid grid-cols-3">
        <UserGrid userSelected={this.handleUserSelected}/>
        <UserGrid userSelected={this.handleUserSelected}/>
        <UserInfo user_id={this.state.user_id}/>
      </div>
    </div>
  }
}

export default App;
