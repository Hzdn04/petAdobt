import React, { useState, useEffect } from "react";
import { deletePet, getPets } from "../../fetchs/petFetch";
import Loading from "../../helpers/Loading";
import { Link } from "react-router-dom";
import { addAdobted } from "../../fetchs/adobtedFetch";
import { getAccount } from "../../fetchs/userFetch";

const ListPetPage = () => {
  const token = localStorage.getItem("access_token");

  const [pets, setPets] = useState([]);

  const [user, setUser] = useState([]);

  const [adobted, setAdobted] = useState({
    petId: 0
  });

  useEffect(() => {
    getPets((result) => setPets(result));
    getAccount((result) => setUser(result));
  }, []);

  const deleteHandler = (id) => {
    deletePet(id);
    getPets((result) => setPets(result));
  };

  const getAdobtHandler = () => {
    addAdobted(adobted)
    // console.log(adobted);
  };

  const styles = {
    card: {
      width: "20rem",
    },
    card_img_top: {
      height: "200px",
    },
    bottom: {
      height: "100px",
      width: "100%",
    },
  };

  return (
    <>
      {token && (
        user.role === 1 &&
        <Link to="/pets/create" className="btn btn-primary mb-2 mt-2">
          Added Pet
        </Link>
      )}

      <div className="row">
        {pets.length !== 0 ? (
          pets.map((pet) => {
            const { id, pet_type, race, age, price, stock, image } = pet;
            return (
              <div class="card mx-2 my-2" style={styles.card} key={id}>
                <img
                  src={image}
                  class="card_img_top img-fluid"
                  style={styles.card_img_top}
                  alt="..."
                />
                <div class="card-body">
                  <h5 class="card-title">
                    {pet_type} {race}
                  </h5>
                  <p class="card-text float-left"> {age} Month</p>
                  <p class="card-text float-right">Rp. {price} </p>
                  {stock > 0 ? (
                    <p class="card-text text-success">
                      {" "}
                      {stock} Stock Available
                    </p>
                  ) : (
                    <p class="card-text text-danger">Out of stock</p>
                  )}

                  {stock > 0 &&
                    (token ? (
                      user.role !== 1 &&
                      <button
                        type="button"
                        class="btn btn-primary float-right" 
                        data-bs-toggle="tooltip" data-bs-placement="top" title="Please, Click 2x"
                        // data-bs-toggle="modal"
                        // data-bs-target="#adobtModal{id}"
                        onClick={() => getAdobtHandler(setAdobted({...adobted, petId:pet.id}))}
                      >
                        Get Adopt
                      </button>
                    ) : (
                      <a
                        class="btn btn-primary float-right"
                        // data-bs-toggle="modal"
                        // data-bs-target="#adobtModal{id}"
                        href="/login"
                      >
                        Get Adopt
                      </a>
                    ))}

                  {token && (
                    user.role === 1 &&
                    <button
                      onClick={() => deleteHandler(+id)}
                      class="btn btn-danger"
                    >
                      DELETE
                    </button>
                  )}

                  {token && (
                    user.role === 1 &&
                    <Link to={`/pets/update/${id}`} class="btn btn-warning">
                      EDIT
                    </Link>
                  )}

                  <div
                    class="modal fade"
                    id="adobtModal{id}"
                    tabindex="-1"
                    aria-labelledby="exampleModalLabel"
                    aria-hidden="true"
                  >
                    <div class="modal-dialog">
                      <div class="modal-content">
                        <div class="modal-header">
                          <h1 class="modal-title fs-5" id="exampleModalLabel">
                            Confirmation
                          </h1>
                          <button
                            type="button"
                            class="btn-close"
                            data-bs-dismiss="modal"
                            aria-label="Close"
                          ></button>
                        </div>
                        <div class="modal-body">
                          Have you ever been here before?
                        </div>
                        <div class="modal-footer">
                          <a
                            type="button"
                            class="btn btn-secondary"
                            href="/adobts/create/<%= pet.id %>"
                          >
                            Nope
                          </a>
                          <a
                            href="/pets/adobt/<%= pet.id %>"
                            type="button"
                            class="btn btn-primary"
                          >
                            Of Course!
                          </a>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            );
          })
        ) : (
          <Loading />
        )}
      </div>
    </>
  );
};

export default ListPetPage;
