import React, { useEffect, useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import axios from "axios";

const LoginPage = (props) => {
  const { loginStatus, loginCbHandler } = props;
  const [form, setForm] = useState({
    email: "",
    password: "",
  });

  const loginUser = async () => {
    try {
      let result = await axios({
        method: "POST",
        url: "http://localhost:3001/users/login",
        data: form,
      });
      const access_token = result.data.access_token;
      localStorage.setItem("access_token", access_token);

      loginCbHandler(true);
    } catch (err) {
      console.log(err);
    }
  };

  const submitHandler = () => {
    loginUser()
  }

  const styles = {
    card: {
      width: "25rem",
    },
  };

  return (
    <>
      <div
        className="card my-3 mx-auto justify-content-center"
        data-aos="fade-up"
        data-aos-delay="100"
        style={styles.card}
      >
        <div className="card-body">
          <form>
            <h1 class="h3 mb-4 fw-normal">Please sign in</h1>

            <div class="form-floating mb-3">
              <input
                onChange={(e) => setForm({ ...form, email: e.target.value })}
                type="email"
                class="form-control"
                id="floatingInput"
                placeholder="name@example.com"
              />
              <label for="floatingInput">Email address</label>
            </div>
            <div class="form-floating">
              <input
                onChange={(e) => setForm({ ...form, password: e.target.value })}
                type="password"
                class="form-control"
                id="floatingPassword"
                placeholder="Password"
              />
              <label for="floatingPassword">Password</label>
            </div>

            <div class="checkbox mb-3">
              <label>
                <input type="checkbox" value="remember-me" /> Remember me
              </label>
            </div>
            <button
              class="w-100 btn btn-lg btn-primary"
              onClick={() => submitHandler()}
              type="submit"
            >
              Sign in
            </button>
            <Link className="link" to="/register">
              <p class="mt-2 mb-3 text-muted">have't account?</p>
            </Link>
          </form>
        </div>
      </div>
    </>
  );
};

export default LoginPage;
