import React from 'react'
import Gluon from '../gluon/core'
import {AgGridColumn, AgGridReact} from 'ag-grid-react';

import 'ag-grid-community/dist/styles/ag-grid.css';
import 'ag-grid-community/dist/styles/ag-theme-alpine.css';

class UserGrid extends React.Component {
  constructor(props) {
    super(props)

    let socket = Gluon.Client.connect()
    let channel = Gluon.Client.join(socket, "UserGrid")

    this.state = {
      socket: socket,
      channel: channel,
      rowSelection: 'multiple',
      rowModelType: 'infinite',
      paginationPageSize: 100,
      cacheOverflowSize: 2,
      maxConcurrentDatasourceRequests: 2,
      infiniteInitialRowCount: 1,
      maxBlocksInCache: 2,
      getRowNodeId: function (item) { return item.id },
      components: {
        loadingCellRenderer: function (params) {
          if (params.value !== undefined) {
            return params.value;
          } else {
            return '<img src="https://www.ag-grid.com/example-assets/loading.gif">';
          }
        },
      }
    }
  }

  componentDidMount() {

  }

  componentWillUnmount() {
    Gluon.Client.disconnect(this.state.socket)
  }

  set_data(payload) {
    this.setState({users: payload.data, attributes: payload.attributes})
  }

  onGridReady = (params) => {
    this.gridApi = params.api;
    this.gridColumnApi = params.columnApi;

    const initDatasource = () => {
      var dataSource = {
        rowCount: null,
        getRows: (params) => {
          console.log('asking for ' + params.startRow + ' to ' + params.endRow);
          this.state.channel.push("data", {filter: params.filterModel, sort: params.sortModel, from: params.startRow, to: params.endRow })
            .receive("ok", payload => {
              let rowsThisPage = JSON.parse(JSON.stringify(payload.data))
              let lastRow = -1;
              if (rowsThisPage.length <= params.endRow) {
                lastRow = rowsThisPage.length;
              }
              params.successCallback(rowsThisPage, lastRow)
            })
            .receive("error", err => {params.failCallback(); console.log("phoenix errored", err)})
            .receive("timeout", () => {params.failCallback(); console.log("timed out pushing")})
        },
      };
      params.api.setDatasource(dataSource);
    };

    initDatasource();

    this.state.channel.on("update", payload => { this.updateData(payload.data.data) })
  };

  updateData(rows) {
    rows.map((row) => {
      let rowNode = this.gridApi.getRowNode(row.id)
      rowNode.setData(row)
    })
  }

  render() {
    return (
      <div>
        <h1>User Grid AG</h1>
        <div id="myGrid" className="ag-theme-alpine" style={{height: "800px"}}>
          <AgGridReact
            columnDefs={this.columnDefs()}
            defaultColDef={this.defaultColDef()}
            rowSelection={this.state.rowSelection}
            rowModelType={this.state.rowModelType}
            paginationPageSize={this.state.paginationPageSize}
            cacheOverflowSize={this.state.cacheOverflowSize}
            maxConcurrentDatasourceRequests={
              this.state.maxConcurrentDatasourceRequests
            }
            infiniteInitialRowCount={this.state.infiniteInitialRowCount}
            maxBlocksInCache={this.state.maxBlocksInCache}
            getRowNodeId={this.state.getRowNodeId}
            components={this.state.components}
            onGridReady={this.onGridReady}
            debug={true}
          />
        </div>
      </div>
    )
  }

  columnDefs() {
    return [
      {
        headerName: 'ID',
        maxWidth: 100,
        valueGetter: 'node.id',
        cellRenderer: 'loadingCellRenderer',
        sortable: false,
        suppressMenu: true,
      },
      {
        field: 'id',
        filter: 'agTextColumnFilter'
      },
      {
        field: 'email',
        filter: 'agTextColumnFilter'
      }
    ]
  }

  defaultColDef() {
    return {
      flex: 1,
      minWidth: 150,
      sortable: true,
      resizable: true,
      floatingFilter: true,
    }
  }
}

export default UserGrid