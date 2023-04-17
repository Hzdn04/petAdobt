import React from "react";
import { Link, useNavigate } from "react-router-dom";
import Swal from "sweetalert2";

const Navbar = (props) => {
  const { loginStatus, loginCbHandler, user } = props;

  //   const loginHandler = () => {
  //     loginCbHandler(true);
  //   };

  const navigate = useNavigate();

  const logoutHandler = () => {
    Swal.fire({
      title: "Are you sure?",
      text: "You wanna Logout?",
      icon: "warning",
      showCancelButton: true,
      confirmButtonColor: "#3085d6",
      cancelButtonColor: "#d33",
      confirmButtonText: "Yes, logout!",
    }).then(async (result) => {
      if (result.isConfirmed) {
        localStorage.clear();
        loginCbHandler(false);
        navigate("/");
        Swal.fire("Logout!", `Now you must login again`, "Success");
      }
    });
  };

  const styles = {
    dropdown: {
      width: "35px",
    },
    icon: {
      width: "35px",
      height: "35px",
    },
  };

  return (
    <>
      <header
        id="header"
        className="fixed-top d-flex align-items-center header-transparent"
      >
        <div className="container d-flex justify-content-between align-items-center">
          <div id="logo">
            {/* <Link to="index.html"><img src="assets/img/logo.png" alt=""></Link> */}

            <h3>
              <Link className="link" to="/">
                petAdobt
              </Link>
            </h3>
          </div>

          <nav id="navbar" className="navbar">
            <ul>
              <li className="nav-link scrollto">
                <Link className="nav-link scrollto " to="/pets">
                  {loginStatus && user.role === 1 ? "Manage Pet" : "Get Adobt"}
                </Link>
              </li>
              {loginStatus && user.role !== 1 && (
                <li className="nav-link scrollto">
                  <Link className="nav-link scrollto " to="/adobteds">
                    Adobted
                  </Link>
                </li>
              )}

              {/* <li><Link className="nav-link scrollto" to="/adobter">Adobters</Link></li>
          <li><Link className="nav-link scrollto" to="/">Adobted Pets</Link></li> */}
              <li>
                <Link className="nav-link scrollto" to="/about">
                  About
                </Link>
              </li>
              {loginStatus ? (
                <div className="dropstart mx-auto" style={styles.dropdown}>
                  <li className="dropdown">
                    <h2 className="text-white mt-3 mx-3">
                      <i className="bi bi-person-circle"></i>
                    </h2>
                    <ul className="dropdown-menu dropdown-menu-end dropdown-menu-lg-start">
                      <li>
                        {loginStatus && <Link to="/profile">Profile</Link>}
                      </li>
                      <li>
                        <Link
                          className="nav-link scrollto"
                          onClick={() => logoutHandler()}
                        >
                          Logout
                        </Link>
                      </li>
                    </ul>
                  </li>
                </div>
              ) : (
                <li>
                  <Link
                    className="nav-link scrollto"
                    to="/login"
                    // onClick={() => loginHandler()}
                  >
                    <h3>
                      <i className="bi bi-box-arrow-in-right"></i>
                    </h3>
                  </Link>
                </li>
              )}
            </ul>
            <i className="bi bi-list mobile-nav-toggle"></i>
          </nav>
        </div>
      </header>
    </>
  );
};

export default Navbar;
