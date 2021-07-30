import React from 'react'
import UserGrid from './user_grid'

const App = ({ name }) => {
  return <div className="h-full flex flex-col">
    <h1 className="text-center">This is Gluon!</h1>
    <div className="flex-grow grid grid-cols-2">
      <UserGrid/>
      <UserGrid/>
    </div>
  </div>
}

export default App;
