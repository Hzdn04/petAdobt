import React, { useEffect, useState } from "react";
import { Link, useNavigate, useParams } from "react-router-dom";
import { getAccount } from "../../fetchs/userFetch";

const ProfilePage = () => {

  const [form, setForm] = useState({});

  useEffect(() => {
    getAccount((result) => {
      setForm(
        (result = {
          id: result.id,
          username: result.username,
          email: result.email,
          name: result.name,
          age: result.age,
          address: result.address,
          phone: result.phone,
          image: result.image,
          role: result.role,
        })
      );
    });
  }, []);

  // console.log(form);
  const styles = {
    height: {
      height: "300px",
    },
    float: {
      float:"right"
    }
  };

  return (
    <div className="mx-auto col-6 mt-3">
      <div class="card mb-3">
        <div className="card-header">
          <div className="text-center">
            <img
              src={form.image}
              class="card-img-top img-fluid rounded" style={styles.height}
              alt="..."
            />
          </div>
        </div>
        <div class="card-body">
          <h5 class="card-title text-center">{form.name}</h5>
          <p class="card-text">{form.email}</p>
          <p class="card-text">
            <small class="text-body-secondary">{form.address}</small>
          </p>
          <div className="float-right">
            <Link to={`/profile/update/${form.id}`} class="btn btn-warning" style={styles.float}>
              EDIT
            </Link>
          </div>
        </div>
      </div>
    </div>
  );
};

export default ProfilePage;
