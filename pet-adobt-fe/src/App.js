import React, { useState, useEffect } from "react";
import "bootstrap/dist/css/bootstrap.css";
import "./App.css";
import { Navbar, Main, Footer } from "./components";
import { getAccount } from './fetchs/userFetch';

function App() {
  const [loginStatus, setLoginStatus] = useState(false);

  const [user, setUser] = useState([]);

    useEffect(() => {
      getAccount((result) => setUser(result));
    }, []);

  const loginCbHandler = (result) => {
    setLoginStatus(result);
  };

  useEffect(() => {
    if (localStorage.getItem("access_token")) {
      setLoginStatus(true);
    } else {
      setLoginStatus(false);
    }
  }, [loginStatus]);

  return (
    <div className="main-page">
      <Navbar
        loginStatus={loginStatus}
        user={user}
        loginCbHandler={loginCbHandler}
      ></Navbar>
      <Main loginStatus={loginStatus} loginCbHandler={loginCbHandler}></Main>
      <Footer></Footer>
    </div>
  );
}

export default App;
