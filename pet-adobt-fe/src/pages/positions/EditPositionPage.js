import React, { useState, useEffect } from "react";
import { getPosition, editPosition } from "../../fetchs/positionFetch";
import { useNavigate, useParams } from "react-router-dom";

const EditPositionPage = () => {
  const [form, setForm] = useState({
    name: "",
    position_player: "",
    skill: "",
  });

  const navigation = useNavigate();
  const params = useParams();

  useEffect(() => {
    const {id} = params;
    getPosition(+id, result => {
      setForm({
        name: result.name,
        position_player: result.position_player,
        skill: result.skill,
      })
    })
  }, [])

  const submitHandler = () => {
    editPosition(+params.id, form);
    navigation("/positions");
    // console.log(form);
  };

  return (
    <>
      <div className="row">
        <h5>Edit position</h5>
        <form>
          <div className="mb-3">
            <label>Name</label>
            <input
            value={form.name}
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
              <option value={form.position_player} selected>
                {form.position_player}
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
            value={form.skill}
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

export default EditPositionPage;
