import React, { useState, useEffect } from "react";
import { addPet } from "../../fetchs/petFetch";
import { getPositions } from "../../fetchs/positionFetch";
import { useNavigate } from "react-router-dom";

const CreatePetPage = () => {
  const [positions, setPositions] = useState([]);

  useEffect(() => {
    getPositions((result) => setPositions(result));
    // console.log(positions);
  }, []);

  const [form, setForm] = useState({
    name: "",
    positionId: 0,
    age: 0,
    city: "",
    photo: "https://via.placeholder.com/100",
  });

  const navigation = useNavigate();

  const submitHandler = () => {
    addPet(form);
    navigation("/pets");
    // console.log(form);
  };

  return (
    <>
      <div className="row">
        <h5>Added Pet</h5>
        <form>
          <div className="mb-3">
            <label>Name</label>
            <input
              onChange={(e) => setForm({ ...form, name: e.target.value })}
              type="text"
              className="form-control"
              placeholder="Name"
            />
          </div>

          <div className="mb-3">
            <label>Position</label>
            <select
              value={form.positionId}
              className="form-select"
              onChange={(e) => setForm({ ...form, positionId: e.target.value })}
            >
              <option selected>PILIH POSISI</option>
              {positions.map((position) => {
                return <option value={position.id}>{position.name}</option>;
              })}
            </select>
          </div>

          <div className="mb-3">
            <label>Age</label>
            <input
              onChange={(e) => setForm({ ...form, age: e.target.value })}
              type="number"
              className="form-control"
              placeholder="Age"
            />
          </div>
          <div className="mb-3">
            <label>City</label>
            <input
              onChange={(e) => setForm({ ...form, city: e.target.value })}
              type="text"
              className="form-control"
              placeholder="City"
            />
          </div>
          <div className="mb-3">
            <label>Photo Link</label>
            <input
              onChange={(e) => setForm({ ...form, photo: e.target.value })}
              type="text"
              className="form-control"
              placeholder="Photo"
            />
          </div>
          <div className="mb-3">
            <button
              onClick={() => submitHandler()}
              type="button"
              className="btn btn-block btn-primary"
            >
              SUBMIT
            </button>
          </div>
        </form>
      </div>
    </>
  );
};

export default CreatePetPage;
