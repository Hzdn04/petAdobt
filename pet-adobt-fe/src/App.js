import React, { useState, useEffect } from 'react';
import 'bootstrap/dist/css/bootstrap.css';
import './App.css';
import {
  Navbar,
  Main,
  Footer
} from './components'

function App(props) {

  const [loginStatus, setLoginStatus] = useState(false)

  const loginCbHandler = (result) => {
    setLoginStatus(result)
  }

  useEffect(() => {
    if (localStorage.getItem('access_token')) {
      setLoginStatus(true)
    } else {
      setLoginStatus(false)
    }
  }, [loginStatus])

  return (
    <div className="main-page">
      <Navbar loginStatus={loginStatus} loginCbHandler={loginCbHandler}></Navbar>
      <Main loginStatus={loginStatus} loginCbHandler={loginCbHandler}></Main>
      <Footer></Footer>
    </div>
  );
}

export default App;
