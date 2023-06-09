import React, { useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import { RegisterUser } from "../../fetchs/userFetch";

const RegisterPage = () => {
  //   const [saveimage, setSaveImage] = useState(null);

  const [form, setForm] = useState({
    username: "",
    email: "",
    password: "",
    name: "",
    age: 0,
    phone: "",
    address: "",
    image: null,
  });

  const navigation = useNavigate();

  const submitHandler = () => {
    console.log(form);
    RegisterUser(form);
    navigation("/");
  };

  //   const uploadImageHandler = (e) => {
  //     console.log(e.target.files[0]);
  //     let image = e.target.files[0];
  //     setSaveImage(image);
  //   };

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
                  name="username"
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
                  name="email"
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
                  name="password"
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
                  name="name"
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
                  name="age"
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
                  name="phone"
                  class="form-control"
                  id="phone"
                  placeholder="085767287872"
                />
                <label className="mx-2" for="phone">
                  Phone
                </label>
              </div>
            </div>
            <div className="mb-3">
              <label for="address" className="mb-2 mx-2">
                Address
              </label>
              <textarea
                onChange={(e) => setForm({ ...form, address: e.target.value })}
                class="form-control"
                name="address"
                id="address"
                rows="3"
              ></textarea>
            </div>
            {/* <div class="mb-3">
              <label className="mb-2 mt-3 mx-2">Upload your pict</label>
              <input
                onChange={(e) => setForm({ ...form, image: e.target.files[0] })}
                name="image"
                type="file"
                class="form-control"
                id="image"
              />
            </div> */}

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
