import React, { useState, useEffect } from "react";
import { getPet, editPet } from "../../fetchs/petFetch";
import { Link, useNavigate, useParams } from "react-router-dom";

const EditPetPage = () => {
  const [form, setForm] = useState({
    pet_type: "",
    race: "",
    age: 0,
    price: 0,
    stock: 0,
    image: null,
  });

  const navigation = useNavigate();
  const params = useParams();

  useEffect(() => {
    const { id } = params;
    getPet(+id, (result) => {
      setForm({
        pet_type: result.pet_type,
        name: result.name,
        description: result.description,
        race: result.race,
        sex: result.sex,
        color: result.color,
        weight: result.weight,
        age: result.age,
        price: result.price,
        stock: result.stock,
        image: result.image,
      });
    });
  }, []);

  const submitHandler = () => {
    editPet(+params.id, form);
    navigation("/pets");
    // console.log(form);
  };

  const styles = {
    card: {
      width: "45rem",
    },
    float: {
      float: "right",
    },
  };

  return (
    <>
      <div className="card mx-auto" style={styles.card}>
        <div className="card-body">
          <h5>Edit Pet</h5>
          <form>
            <div className="mb-3">
              <label>Pet</label>
              <select
                onChange={(e) => setForm({ ...form, pet_type: e.target.value })}
                class="form-select"
                name="pet_type"
                for="pet_type"
                id="pet_type"
              >
                <option value={form.pet_type} selected>
                  {form.pet_type}
                </option>
                <option name="pet_type" value="Cat">
                  Cat
                </option>
                <option name="pet_type" value="Dog">
                  Dog
                </option>
                <option name="pet_type" value="Turt">
                  Turtle
                </option>
                <option name="pet_type" value="Hams">
                  Hams
                </option>
                <option name="pet_type" value="Bird">
                  Bird
                </option>
                <option name="pet_type" value="Fish">
                  Fish
                </option>
              </select>
            </div>

            <div className="mb-3">
              <label>Name</label>
              <input
                value={form.name}
                onChange={(e) => setForm({ ...form, name: e.target.value })}
                type="text"
                className="form-control"
                placeholder="Jack"
              />
            </div>

            <div className="mb-3">
              <label>Description</label>
              <textarea
                onChange={(e) =>
                  setForm({ ...form, description: e.target.value })
                }
                class="form-control"
                name="description"
                id="description"
                rows="3"
                value={form.description}
              ></textarea>
            </div>

            <div className="mb-3">
              <label>Race</label>
              <input
                value={form.race}
                onChange={(e) => setForm({ ...form, race: e.target.value })}
                type="text"
                className="form-control"
                placeholder="Persia"
              />
            </div>

            <div className="mb-3">
              <label>Sex</label>
              <select
                onChange={(e) => setForm({ ...form, sex: e.target.value })}
                class="form-select"
                name="sex"
                for="sex"
                id="sex"
              >
                <option value={form.sex} selected>
                  {form.sex}
                </option>
                <option name="sex" value="Male">
                  Male
                </option>
                <option name="sex" value="Female">
                  Female
                </option>
                <option name="sex" value="Unknown">
                  Unknown
                </option>
              </select>
            </div>

            <div className="mb-3">
              <label>Color</label>
              <input
                onChange={(e) => setForm({ ...form, color: e.target.value })}
                type="text"
                className="form-control"
                placeholder="White"
                value={form.color}
              />
            </div>

            <div className="mb-3">
              <label>Weight (kg)</label>
              <input
                onChange={(e) => setForm({ ...form, weight: e.target.value })}
                type="number"
                className="form-control"
                placeholder="in kg"
                value={form.weight}
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
              <label>Price</label>
              <input
                value={form.price}
                onChange={(e) => setForm({ ...form, price: e.target.value })}
                type="number"
                className="form-control"
                placeholder="200000"
              />
            </div>
            <div className="mb-3">
              <label>Stock</label>
              <input
                value={form.stock}
                onChange={(e) => setForm({ ...form, stock: e.target.value })}
                type="number"
                className="form-control"
                placeholder="2"
              />
            </div>
            <div className="mb-3">
              <label>Image Link</label>
              <input
                //   value={form.image}
                onChange={(e) => setForm({ ...form, image: e.target.files[0] })}
                type="file"
                className="form-control"
                placeholder="Photo"
              />
            </div>
            <div className="mb-3">
              <Link className="btn btn-warning" to="/pets">
                Cancel
              </Link>
              <button
                onClick={() => submitHandler()}
                type="button"
                className="btn btn-block btn-primary"
                style={styles.float}
              >
                SUBMIT
              </button>
            </div>
          </form>
        </div>
      </div>
    </>
  );
};

export default EditPetPage;
