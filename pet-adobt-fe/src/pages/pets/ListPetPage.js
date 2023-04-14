import React, { useState, useEffect } from "react";
import { deletePet, getPets } from "../../fetchs/petFetch";
import Loading from "../../helpers/Loading";
import { Link } from "react-router-dom";

const ListPetPage = () => {
  const [pets, setPets] = useState([]);

  useEffect(() => {
    getPets((result) => setPets(result.pets));
  }, []);

  const deleteHandler = (id) => {
    deletePet(id);
    getPets((result) => setPets(result));
  };

  const styles = {
    card: {
      width: "20rem",
    },
    card_img_top: {
      height: "200px",
    },
  };

  return (
    <>
      <Link to="/pets/create" className="btn btn-primary mb-2 mt-2">
        Add
      </Link>
      <div className="row">
      {pets.length !== 0 ? 
      (
        pets.map((pet) => {
          const { id, pet_type, race, age, price, stock } = pet;
          return (
            <div class="card mr-4" style={styles.card} key={id}>
              <img
                src="https://via.placeholder.com/100"
                class="card_img_top img-fluid"
                style={styles.card_img_top}
                alt="..."
              />
              <div class="card-body">
                <h5 class="card-title">{pet_type} {race}</h5>
                <p class="float-right card-text"> {age} Month</p>
                <p class="card-text">Rp. {price} </p>
                <p class="card-text"> {stock} Stock Available</p>

                <button
                  type="button"
                  class="btn btn-primary float-right"
                  data-bs-toggle="modal"
                  data-bs-target="#adobtModal<%= pet.id %>"
                >
                  Get Adopt
                </button>

                {/* <h5 class="card-title"></h5>
          <p class="float-right card-text"> Month</p>
          <p class="card-text">Rp. </p>
          <p class="card-text" >Out of stock</p>

          <a href="/pets/delete/<%= pet.id %>" class="btn btn-sm btn-danger">
            <i class="fa fa-trash"></i>
          </a>
          <a href="/pets/update/<%= pet.id %>" class="btn btn-sm btn-warning">
            <i class="fa fa-edit"></i>
          </a>

          <button
            type="button"
            class="btn btn-primary float-right"
            data-bs-toggle="modal"
            data-bs-target="#adobtModal<%= pet.id %>"
            disabled
          >
            Get Adopt
          </button> */}

                <div
                  class="modal fade"
                  id="adobtModal<%= pet.id %>"
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
      ) 
      : (
        <Loading />
      )}
      </div>
    </>
  );
};

export default ListPetPage;
