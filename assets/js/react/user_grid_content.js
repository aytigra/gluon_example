import React from 'react'
import {AgGridColumn, AgGridReact} from 'ag-grid-react';

import 'ag-grid-community/dist/styles/ag-grid.css';
import 'ag-grid-community/dist/styles/ag-theme-alpine.css';

class UserGridContent extends React.Component {
  constructor(props) {
    super(props)

    this.state = {modal_shown: false}
  }

  render() {
    return <div>
      <h1>User Grid AG</h1>

      <div className="ag-theme-alpine" style={{height: 400, width: 600}}>
           <AgGridReact
               rowData={this.props.users}>
               <AgGridColumn field="id" sortable={ true } filter={ true }></AgGridColumn>
               <AgGridColumn field="email" sortable={ true } filter={ true }></AgGridColumn>
           </AgGridReact>
       </div>
    </div>
  }
}

export default UserGridContent
