import React, { useState } from "react";
import { Link } from "react-router-dom";
import Swal from "sweetalert2";

const Navbar = (props) => {
  const { loginStatus, loginCbHandler } = props;

  const loginHandler = () => {
    loginCbHandler(true);
  };

  const logoutHandler = () => {
    Swal.fire({
      title: 'Are you sure?',
      text: "You wanna Logout?",
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#3085d6',
      cancelButtonColor: '#d33',
      confirmButtonText: 'Yes, logout!'
    }).then(async (result) => {
      if (result.isConfirmed) {
        localStorage.clear()
        loginCbHandler(false)
        Swal.fire(
          'Logout!',
          `Now you must login again`,
          'Success'
        )
      }
    })
    
  };

  return (
    <>
      <header
        id="header"
        class="sticky-top d-flex align-items-center header-transparent"
      >
        <div class="container d-flex justify-content-between align-items-center">
          <div id="logo">
            {/* <Link to="index.html"><img src="assets/img/logo.png" alt=""></Link> */}

            <h3>
              <Link className="link" to="/">
                petAdobt
              </Link>
            </h3>
          </div>

          <nav id="navbar" class="navbar">
            <ul>
              <li>
                <Link class="nav-link scrollto active" to="/pets">
                  Get Adobt
                </Link>
              </li>
              {/* <li><Link class="nav-link scrollto" to="/adobter">Adobters</Link></li>
          <li><Link class="nav-link scrollto" to="/">Adobted Pets</Link></li> */}
              <li>
                <Link class="nav-link scrollto" to="/about">
                  About
                </Link>
              </li>
              
              <li>
                {loginStatus ? (
                  <Link
                    class="nav-link scrollto"
                    onClick={() => logoutHandler()}
                  >
                    Logout
                  </Link>
                ) : (
                  <Link
                    class="nav-link scrollto"
                    to="/login"
                    // onClick={() => loginHandler()}
                  >
                    Login
                  </Link>
                )}
              </li>
            </ul>
            <i class="bi bi-list mobile-nav-toggle"></i>
          </nav>
        </div>
      </header>
    </>
  );
};

export default Navbar;
