import React, {useEffect, useState} from "react";
import { useNavigate, useParams } from "react-router-dom";
import { getAccount } from "../../fetchs/userFetch";

const ProfilePage = () => {

  const navigation = useNavigate();
  const params = useParams();
  
  const [form, setForm] = useState({});

  useEffect(() => {
    const {id} = params;
    getAccount(+id, result => {
      setForm({
        username: result.username,
        email: result.email,
        name: result.name,
        age: result.age,
        address: result.address,
        phone: result.phone,
        image: result.image,
        role: result.role,
      })
    })
  }, [])



  return (
    <div className="mx-auto col-6 mt-3">
      <div class="card mb-3">
        <div className="card-header">
        <div className="text-center">
        <img src="https://akcdn.detik.net.id/community/media/visual/2023/03/19/zlatan-ibrahimovic_169.jpeg?w=700&q=90" class="card-img-top img-fluid rounded" alt="..." />
        </div>
        </div>
        <div class="card-body">
          <h5 class="card-title text-center">{form.name}</h5>
          <p class="card-text">
            This is a wider card with supporting text below as a natural lead-in
            to additional content. This content is a little bit longer.
          </p>
          <p class="card-text">
            <small class="text-body-secondary">Last updated 3 mins ago</small>
          </p>
        </div>
      </div>
    </div>
  );
};

export default ProfilePage;
