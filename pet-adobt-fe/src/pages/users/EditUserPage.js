import React, { useState, useEffect } from "react";
import { getAccount, editAccount } from "../../fetchs/userFetch";
import { Link, useNavigate, useParams } from "react-router-dom";

const EditUserPage = () => {
  const [form, setForm] = useState({
    username: "",
    email: "",
    password: null,
    name: "",
    age: 0,
    address: "",
    phone: "",
    image: "",
    role: 0,
  });

  const navigation = useNavigate();
  const params = useParams();

  // console.log(params);
  useEffect(() => {
    getAccount((result) => {
      setForm({
        username: result.username,
        email: result.email,
        password: result.password,
        name: result.name,
        age: result.age,
        address: result.address,
        phone: result.phone,
        image: result.image,
        role: result.role,
      });
    });
  }, []);

  const submitHandler = () => {
    editAccount(params.id, form);
    navigation("/profile");
    // console.log(form);
  };

  const styles = {
    card: {
      width: "45rem",
    },
    float: {
      float:"right"
    }
  };

  return (
    <>
      <div className="card mx-auto" style={styles.card}>
        <div className="card-body">
          <h4 className="text-center">Edit Your Acoount</h4>
          <form>
            <div className="mb-3">
              <label>Username</label>
              <input
                value={form.username}
                onChange={(e) => setForm({ ...form, username: e.target.value })}
                type="text"
                className="form-control"
                readOnly
              />
            </div>
            <div className="mb-3">
              <label>Email</label>
              <input
                value={form.email}
                onChange={(e) => setForm({ ...form, email: e.target.value })}
                type="email"
                className="form-control"
              />
            </div>

            <div className="mb-3">
              <label>Password</label>
              <input
                value={form.password}
                onChange={(e) => setForm({ ...form, password: e.target.value })}
                type="password"
                className="form-control"
                readOnly
              />
            </div>
            <div className="mb-3">
              <label>Name</label>
              <input
                value={form.name}
                onChange={(e) => setForm({ ...form, name: e.target.value })}
                type="text"
                className="form-control"
                placeholder="2"
              />
            </div>
            <div className="mb-3">
              <label>Age</label>
              <input
                value={form.age}
                onChange={(e) => setForm({ ...form, age: e.target.value })}
                type="number"
                className="form-control"
                placeholder="2"
              />
            </div>
            <div className="mb-3">
              <label>Address</label>
              <textarea
                onChange={(e) => setForm({ ...form, address: e.target.value })}
                class="form-control"
                id="exampleFormControlTextarea1"
                rows="3"
                value={form.address}
              ></textarea>
            </div>
            <div className="mb-3">
              <label>Phone</label>
              <input
                value={form.phone}
                onChange={(e) => setForm({ ...form, phone: e.target.value })}
                type="text"
                className="form-control"
                placeholder="2"
              />
            </div>
            <div className="mb-3">
              <label>Image Link</label>
              <input
                value={form.image}
                onChange={(e) => setForm({ ...form, image: e.target.value })}
                type="text"
                className="form-control"
                placeholder="Photo"
              />
            </div>
            <div className="mb-3">
            <label>Role</label>
            <select
              onChange={(e) => setForm({ ...form, role: e.target.value })}
                class="form-select"
                name="role"
                for="role"
                id="role"
              >
                <option value={form.role} selected>{form.role === 1 ? "Admin" : "User"}</option>
                <option name="role" value={1}>Admin</option>
                <option name="role" value={2}>User</option>
              </select>
          </div>
            <div className="mb-3">
              <button
                style={styles.float}
                onClick={() => submitHandler()}
                type="button"
                className="btn btn-block btn-primary"
              >
                SUBMIT
              </button>
              <Link className="btn btn-warning" to="/profile" >Cancel</Link>
            </div>
          </form>
        </div>
      </div>
    </>
  );
};

export default EditUserPage;
