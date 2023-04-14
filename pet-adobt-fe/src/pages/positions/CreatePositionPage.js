import React, { useState } from "react";
import { addPosition } from "../../fetchs/positionFetch";
import { useNavigate } from "react-router-dom";

const CreatePositionPage = () => {
  const [form, setForm] = useState({
    name: "",
    position_player: "",
    skill: "",
  });

  const navigation = useNavigate();

  const submitHandler = () => {
    addPosition(form);
    navigation("/positions");
    // console.log(form);
  };

  return (
    <>
      <div className="row">
        <h5>Added Position</h5>
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
              className="form-select"
              onChange={(e) => setForm({ ...form, position_player: e.target.value })}
            >
              <option value='' selected>
                PILIH POSISI
              </option>
              <option value='Defender'>
                Defender
              </option>
              <option value='GoalKeeper'>
                GoalKeeper
              </option>
              <option value='Midfielder'>
                Midfielder
              </option>
              <option value='Striker'>
                Striker
              </option>
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

export default CreatePositionPage;
