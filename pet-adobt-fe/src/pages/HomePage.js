import React from "react";
import { Link } from "react-router-dom";

const HomePage = (props) => {
  const { loginStatus, loginCbHandler } = props;
  const token = localStorage.access_token;
  const styles = {
    hero: {
      backgroundImage: `url('${process.env.PUBLIC_URL}/images/bg_1.jpg')`,
    },
  };
  return (
    <>
      <section id="hero">
        <div className="hero-container" data-aos="zoom-in" data-aos-delay="100">
          <h1>Welcome to petAdobt</h1>
          <h2>Highest Quality Care For Pets You'll Love</h2>
          {!token ? (
            <Link to="/login" className="btn-get-started">
              Login
            </Link>
          ) : (
            <Link to="/pets" className="btn-get-started">
              Manage Pets
            </Link>
          )}
        </div>
      </section>
    </>
  );
};

export default HomePage;
