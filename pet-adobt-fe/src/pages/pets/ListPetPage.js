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

  // Filter Category
  const [filteredPets, setFilteredPets] = useState([]);
  const [selectedCategory, setSelectedCategory] = useState("");
  // const [selectedType, setSelectedType] = useState("");

  const handleCategoryChange = (event) => {
    const type = event.target.value;
    setSelectedCategory(type);

    if (type === "") {
      setFilteredPets(pets);
    } else {
      const filtered = pets.filter((pet) => pet.pet_type === type);
      setFilteredPets(filtered);
    }
  };

  // Pagination
  // const [currentPage, setCurrentPage] = useState(1);
  // const [petsPerPage, setPetsPerPage] = useState(5);

  // const indexOfLastPet = currentPage * petsPerPage;
  // const indexOfFirstPet = indexOfLastPet - petsPerPage;
  // const currentPets = filteredPets.slice(indexOfFirstPet, indexOfLastPet);
  // const totalPages = Math.ceil(pets.length / petsPerPage);

  // const handleClick = (page) => {
  //   setCurrentPage(page);
  // };

  // const renderPagination = () => {
  //   const pages = [];
  //   for (let i = 1; i <= totalPages; i++) {
  //     pages.push(
  //       <li
  //         key={i}
  //         className={`page-item ${currentPage === i ? "active" : null}`}
  //       >
  //         <a href="#" className="page-link" onClick={() => handleClick(i)}>
  //           {i}
  //         </a>
  //       </li>
  //     );
  //   }
  //   return pages;
  // };

  // const handleTypeChange = (event) => {
  //   setSelectedType(event.target.value);
  // };

  // const handleTypeChange = (event) => {
  //   setSelectedType(event.target.value);
  // };

  // mengambil data pet untuk dikirm ke petAdobt
  const [adobted, setAdobted] = useState({
    petId: 0,
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
    addAdobted(adobted);
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
    float: {
      float: "right",
    },
  };

  return (
    <>
      {token && user.role === 1 ? (
        <div className="row">
          <h4 className="text-center mt-3">Pets Management</h4>
          <Link to="/pets/create" className="btn btn-primary mb-2 mt-2">
            Added Pet
          </Link>
        </div>
      ) : (
        <div class="alert alert-warning my-3" role="alert">
          <h4 class="alert-heading text-center">Pets Collection</h4>
          <p className="text-center my-3">
            please adopt a pet that you think is suitable
          </p>
        </div>
      )}
      <div className="row my-3">
        <div className="col-3">
          <select
            class="form-select"
            value={selectedCategory}
            onChange={handleCategoryChange}
          >
            <option value="">All Categories</option>
            <option value="Cat">Cat</option>
            <option value="Dog">Dog</option>
          </select>
        </div>
      </div>
      <div className="row">
        {filteredPets.length !== 0 ? (
          filteredPets.map((pet) => {
            const { id, pet_type, race, age, price, stock, image } = pet;
            return (
              <div class="card mx-2 my-2" style={styles.card} key={id}>
                <img
                  // src={image[0].url}
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
                      user.role !== 1 && (
                        <button
                          type="button"
                          class="btn btn-primary float-right"
                          data-bs-toggle="tooltip"
                          data-bs-placement="top"
                          title="Please, Click 2x"
                          style={styles.float}
                          // data-bs-toggle="modal"
                          // data-bs-target="#adobtModal{id}"
                          onClick={() =>
                            getAdobtHandler(
                              setAdobted({ ...adobted, petId: pet.id })
                            )
                          }
                        >
                          Get Adopt
                        </button>
                      )
                    ) : (
                      <a
                        class="btn btn-primary float-right"
                        style={styles.float}
                        href="/login"
                      >
                        Get Adopt
                      </a>
                    ))}

                  {token && user.role === 1 && (
                    <button
                      onClick={() => deleteHandler(+id)}
                      class="btn btn-danger"
                      style={styles.float}
                    >
                      DELETE
                    </button>
                  )}

                  {token && user.role === 1 && (
                    <Link
                      to={`/pets/update/${id}`}
                      class="btn btn-warning mx-2"
                      style={styles.float}
                    >
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
