import React, { useState, useEffect } from "react";
import { addAdobted } from "../../fetchs/adobtedFetch";
import { getPet } from "../../fetchs/petFetch";
import { useNavigate } from "react-router-dom";

const CreateAdobtedPage = () => {
  const [pets, setPet] = useState([]);

  useEffect(() => {
    getPet((result) => setPet(result));
    // console.log(pets);
  }, []);

  const [form, setForm] = useState({
    petId: 0,
    userId: 0,
    adobt_date: "",
    total_price: 0,
    address: "",
  });

  const navigation = useNavigate();

  const submitHandler = () => {
    addAdobted(form);
    navigation("/adobteds");
    // console.log(form);
  };

  return (
    <>
      <div className="row">
        <h5>Added Adobted</h5>
        <form>
          <div className="mb-3">
            <label>Pet</label>
            <select
              value={form.petId}
              onChange={(e) => setForm({ ...form, petId: e.target.value })}
              id="adobtId"
              name="adobtId"
              class="form-select"
            >
              <option value={form.petId} selected>{form.name}</option>
              {pets.map((pet) => {
                return <option value={pet.id}>{pet.name}</option>;
              })}
            </select>
          </div>

          <div className="mb-3">
            <label>Position</label>
            <select
              className="form-select"
              onChange={(e) =>
                setForm({ ...form, position_player: e.target.value })
              }
            >
              <option value="" selected>
                PILIH POSISI
              </option>
              <option value="Defender">Defender</option>
              <option value="GoalKeeper">GoalKeeper</option>
              <option value="Midfielder">Midfielder</option>
              <option value="Striker">Striker</option>
            </select>
          </div>

          <div className="mb-3">
            <label>Skill</label>
            <input
              onChange={(e) => setForm({ ...form, skill: e.target.value })}
              type="text"
              className="form-control"
              placeholder="Skill"
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

export default CreateAdobtedPage;
