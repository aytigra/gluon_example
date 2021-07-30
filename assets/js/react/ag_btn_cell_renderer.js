import React, { Component } from 'react'

class AgBtnCellRenderer extends Component {
  constructor(props) {
    super(props);
    this.btnClickedHandler = this.btnClickedHandler.bind(this);
  }
  btnClickedHandler() {
    this.props.clicked(this.props);
  }
  render() {
    return (
      <button onClick={this.btnClickedHandler}>{this.props.text}</button>
    )
  }
}

export default AgBtnCellRenderer
