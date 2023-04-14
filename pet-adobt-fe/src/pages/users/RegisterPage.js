import React, { useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import axios from "axios";
import { RegisterUser } from "../../fetchs/userFetch";

const RegisterPage = () => {
  const [users, setUsers] = useState([]);

  const [form, setForm] = useState({
    username: "",
    email: "",
    password: "",
    name: "",
    age: 0,
    phone: "",
    address: "",
    photo: "",
  });

  const navigation = useNavigate();

  const submitHandler = () => {
    RegisterUser(form);
    navigation("/login");
  };

  const styles = {
    card: {
      width: "50rem",
    },
  };

  return (
    <div>
      <div
        className="card my-3 mx-auto justify-content-center"
        data-aos="fade-up"
        data-aos-delay="100"
        style={styles.card}
      >
        <div className="card-body">
          <form>
            <h1 class="h3 mb-4 fw-normal text-center">Register</h1>

            <div className="row">
              <div class="col-6 form-floating mb-3">
                <input
                  onChange={(e) =>
                    setForm({ ...form, username: e.target.value })
                  }
                  type="text"
                  class="form-control"
                  id="username"
                  placeholder="roketo23"
                />
                <label className="mx-2" for="floatingInput">
                  Username
                </label>
              </div>
              <div class="col-6 form-floating mb-3">
                <input
                  onChange={(e) => setForm({ ...form, email: e.target.value })}
                  type="email"
                  class="form-control"
                  id="floatingInput"
                  placeholder="name@example.com"
                />
                <label className="mx-2" for="floatingInput">
                  Email address
                </label>
              </div>
            </div>
            <div className="row">
              <div class="col-6 form-floating mb-3">
                <input
                  onChange={(e) =>
                    setForm({ ...form, password: e.target.value })
                  }
                  type="password"
                  class="form-control"
                  id="floatingPassword"
                  placeholder="Password"
                />
                <label className="mx-2" for="floatingPassword">
                  Password
                </label>
              </div>
              <div class="col-6 form-floating mb-3">
                <input
                  onChange={(e) => setForm({ ...form, name: e.target.value })}
                  type="text"
                  class="form-control"
                  id="name"
                  placeholder="Joko Susilo"
                />
                <label className="mx-2" for="name">
                  Name
                </label>
              </div>
            </div>
            <div className="row">
              <div class="col-6 form-floating mb-3">
                <input
                  onChange={(e) => setForm({ ...form, age: e.target.value })}
                  type="number"
                  class="form-control"
                  id="age"
                  placeholder="name@example.com"
                />
                <label className="mx-2" for="age">
                  Age
                </label>
              </div>

              <div class="col-6 form-floating mb-3">
                <input
                  onChange={(e) => setForm({ ...form, phone: e.target.value })}
                  type="text"
                  class="form-control"
                  id="phone"
                  placeholder="085767287872"
                />
                <label className="mx-2" for="phone">
                  Phone
                </label>
              </div>
            </div>
            <div className="">
              <label for="address" className="mb-2 mx-2">
                Address
              </label>
              <textarea
                onChange={(e) => setForm({ ...form, address: e.target.value })}
                class="form-control"
                id="address"
                rows="3"
              ></textarea>
            </div>
            <div class="mb-3">
              <label className="mb-2 mt-3 mx-2">Upload your pict</label>
              <input
                onChange={(e) => setForm({ ...form, photo: e.target.value })}
                type="text"
                class="form-control"
                id="floatingInput"
              />
            </div>

            <button
              class="w-100 btn btn-lg btn-primary"
              onClick={() => submitHandler()}
              type="submit"
            >
              Sign up
            </button>
            <Link className="link" to="/register">
              <p class="mt-2 mb-3 text-muted">login here!</p>
            </Link>
          </form>
        </div>
      </div>
    </div>
  );
};

export default RegisterPage;
