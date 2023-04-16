import React, { useState, useEffect } from "react";
import { getPet, editPet } from "../../fetchs/petFetch";
import { useNavigate, useParams } from "react-router-dom";

const EditPetPage = () => {
  const [form, setForm] = useState({});

  const navigation = useNavigate();
  const params = useParams();

  useEffect(() => {
    const {id} = params;
    getPet(+id, result => {
      setForm({
        name: result.name,
        positionId: +result.positionId,
        age: +result.age,
        city: result.city,
        photo: result.photo,
      })
    })
  }, [])

  const submitHandler = () => {
    editPet(+params.id, form);
    navigation("/pets");
    // console.log(form);
  };

  return (
    <>
      <div className="row">
        <h5>Edit Pet</h5>
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
            <input
            value={form.positionId}
              onChange={(e) => setForm({ ...form, positionId: e.target.value })}
              type="number"
              className="form-control"
              placeholder="Position"
            />
          </div>

          {/* <div className="mb-3">
            <label>Position</label>
            <select
              id="positionId"
              name="positionId"
              className="form-select"
              onChange={(e) => setForm({ ...form, positionId: e.target.value })}
            >
              <option value="" selected>
                PILIH POSISI
              </option>

            </select>
          </div> */}

          <div className="mb-3">
            <label>Age</label>
            <input
            value={form.age}
              onChange={(e) => setForm({ ...form, age: e.target.value })}
              type="number"
              className="form-control"
              placeholder="Age"
            />
          </div>
          <div className="mb-3">
            <label>City</label>
            <input
            value={form.city}
              onChange={(e) => setForm({ ...form, city: e.target.value })}
              type="text"
              className="form-control"
              placeholder="City"
            />
          </div>
          <div className="mb-3">
            <label>Photo Link</label>
            <input
            value={form.photo}
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

export default EditPetPage;
