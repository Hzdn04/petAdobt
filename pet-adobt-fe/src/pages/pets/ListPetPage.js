import React, { useState, useEffect } from "react";
import { Button, Modal } from "react-bootstrap";
import { deletePet, getPets } from "../../fetchs/petFetch";
import Loading from "../../helpers/Loading";
import { Link, useNavigate } from "react-router-dom";
import { addAdobted } from "../../fetchs/adobtedFetch";
import { getAccount } from "../../fetchs/userFetch";
import Swal from "sweetalert2";
import convertRp from "../../helpers/RpFormatter";

const ListPetPage = () => {
  const token = localStorage.getItem("access_token");

  const navigate = useNavigate();

  const [pets, setPets] = useState([]);

  const [user, setUser] = useState([]);

  const [show, setShow] = useState(false);

  const handleShow = (id) => {
    const petById = pets.filter((pet) => pet.id === id);
    setCurrentPet(petById);
    setShow(true);
  };
  const handleClose = () => setShow(false);

  // Filter Category
  const [filteredPets, setFilteredPets] = useState([]);
  const [selectedCategory, setSelectedCategory] = useState("all");
  const [currentPet, setCurrentPet] = useState([]);
  // const [selectedType, setSelectedType] = useState("");

  const handleCategoryChange = (event) => {
    const type = event.target.value;
    setSelectedCategory(type);

    if (type !== "all") {
      const filtered = pets.filter((pet) => pet.pet_type === type);
      setFilteredPets(filtered);
      console.log(filtered);
    } else {
      setFilteredPets(pets);
    }
    console.log(pets);
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

  const deleteHandler = async (id) => {
    Swal.fire({
      title: "Are you sure?",
      text: "You won't be able to revert this!",
      icon: "warning",
      showCancelButton: true,
      confirmButtonColor: "#3085d6",
      cancelButtonColor: "#d33",
      confirmButtonText: "Yes, delete it!",
    }).then(async (result) => {
      if (result.isConfirmed) {
        await deletePet(id);
        await Swal.fire("Deleted!", `pet ${id} has been deleted`, "Success");
        window.location.reload();
      }
    });
    // try {
    //   await deletePet(id);
    //   getPets((result) => setPets(result));
    //   navigate("/pets");
    // } catch (err) {
    //   console.log(err);
    // }
  };

  const getAdobtHandler = () => {
    Swal.fire({
      title: "Adopt this pet?",
      text: "This pet will be add to your transaction",
      icon: "warning",
      showCancelButton: true,
      confirmButtonColor: "#3085d6",
      cancelButtonColor: "#d33",
      confirmButtonText: "Sure!",
    }).then(async (result) => {
      if (result.isConfirmed) {
        console.log(adobted);
        addAdobted(adobted);
        navigate("/adobteds");
        // Swal.fire("Adopted!", `Go see your pets!`, "Success");
      }
      //   addAdobted(adobted);
      // localStorage.clear();
      //   loginCbHandler(false);
      //   navigate("/");
    });
    // addAdobted(adobted);
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
            Add Pet
          </Link>
        </div>
      ) : (
        <div className="alert alert-warning my-3" role="alert">
          <h4 className="alert-heading text-center">Pets Collection</h4>
          <p className="text-center my-3">
            please adopt a pet that you think is suitable
          </p>
        </div>
      )}
      <div className="row my-3">
        <div className="col-3">
          <select
            className="form-select"
            value={selectedCategory}
            onChange={handleCategoryChange}
          >
            <option value="all" selected>
              All Categories
            </option>
            <option value="Cat">Cat</option>
            <option value="Dog">Dog</option>
            <option value="Turtle">Turtle</option>
            <option value="Hams">Hams</option>
            <option value="Bird">Bird</option>
            <option value="Fish">Fish</option>
          </select>
        </div>
      </div>
      <div className="row">
        {filteredPets.length !== 0 ? (
          filteredPets.map((pet) => {
            const { id, pet_type, race, age, price, stock, image } = pet;
            return (
              <div className="card mx-2 my-2" style={styles.card} key={id}>
                <img
                  // src={image[0].url}
                  src={image}
                  className="card_img_top img-fluid"
                  style={styles.card_img_top}
                  alt="..."
                />
                <div className="card-body">
                  <h5 className="card-title">
                    {pet_type} {race}
                  </h5>
                  <p className="card-text float-left"> {age} Month</p>
                  <p className="card-text float-right">{convertRp(price)} </p>
                  {stock > 0 ? (
                    <p className="card-text text-success">
                      {" "}
                      {stock} Stock Available
                    </p>
                  ) : (
                    <p className="card-text text-danger">Out of stock</p>
                  )}

                  {stock > 0 &&
                    (token ? (
                      user.role !== 1 && (
                        <button
                          type="button"
                          className="btn btn-primary float-right"
                          //   data-bs-toggle="tooltip"
                          //   data-bs-placement="top"
                          //   title="Please, Click 2x"
                          style={styles.float}
                          // data-bs-toggle="modal"
                          // data-bs-target="#adobtModal{id}"
                          onClick={() =>
                            getAdobtHandler(
                              setAdobted({ ...adobted, petId: id })
                            )
                          }
                        >
                          Get Adopt
                        </button>
                      )
                    ) : (
                      <a
                        className="btn btn-primary float-right"
                        style={styles.float}
                        href="/login"
                      >
                        Get Adopt
                      </a>
                    ))}

                  {token && user.role === 1 && (
                    <button
                      onClick={() => deleteHandler(+id)}
                      className="btn btn-danger"
                      style={styles.float}
                    >
                      DELETE
                    </button>
                  )}

                  {token && user.role === 1 && (
                    <Link
                      to={`/pets/update/${id}`}
                      className="btn btn-warning mx-2"
                      style={styles.float}
                    >
                      EDIT
                    </Link>
                  )}

                  {token && user.role === 1 && (
                    // <Link
                    //   to={`/pets/update/${id}`}
                    //   className="btn btn-primary mx-1"
                    //   style={styles.float}
                    //   data-bs-toggle="modal"
                    //   data-bs-target={`#detailModal-${pets.id}`}
                    // >
                    //   DETAIL
                    // </Link>
                    <Button variant="primary" onClick={handleShow}>
                      DETAIL
                    </Button>
                  )}

                  <Modal show={show} onHide={handleClose}>
                    <Modal.Header closeButton>
                      <Modal.Title>Modal heading</Modal.Title>
                    </Modal.Header>
                    <Modal.Body>
                      Woohoo, you're reading this text in a modal!
                    </Modal.Body>
                    <Modal.Footer>
                      <Button variant="secondary" onClick={handleClose}>
                        Close
                      </Button>
                      <Button variant="primary" onClick={handleClose}>
                        Save Changes
                      </Button>
                    </Modal.Footer>
                  </Modal>

                  {/* <div
                    className="modal fade"
                    id={`detailModal-${pets.id}`}
                    tabIndex="-1"
                    aria-labelledby={`detailModalLabel-${id}`}
                    aria-hidden="false"
                  >
                    <div className="modal-dialog">
                      <div className="modal-content">
                        <div className="modal-header">
                          <h5
                            className="modal-title"
                            id={`detailModalLabel-${id}`}
                          >
                            Detail Pet
                          </h5>
                          <button
                            type="button"
                            className="btn-close"
                            data-bs-dismiss="modal"
                            aria-label="Close"
                          ></button>
                        </div>
                        <div className="modal-body">
                          <h5>{pet_type}</h5>
                          <p>Race: {race}</p>
                          <p>Age: {age} Month</p>
                          <p>Price: {convertRp(price)}</p>
                        </div>
                        <div className="modal-footer">
                          <button
                            type="button"
                            className="btn btn-secondary"
                            data-bs-dismiss="modal"
                          >
                            Close
                          </button>
                          
                        </div>
                      </div>
                    </div>
                  </div> */}

                  <div
                    className="modal fade"
                    id="adobtModal{id}"
                    tabindex="-1"
                    aria-labelledby="exampleModalLabel"
                    aria-hidden="true"
                  >
                    <div className="modal-dialog">
                      <div className="modal-content">
                        <div className="modal-header">
                          <h1
                            className="modal-title fs-5"
                            id="exampleModalLabel"
                          >
                            Confirmation
                          </h1>
                          <button
                            type="button"
                            className="btn-close"
                            data-bs-dismiss="modal"
                            aria-label="Close"
                          ></button>
                        </div>
                        <div className="modal-body">
                          Have you ever been here before?
                        </div>
                        <div className="modal-footer">
                          <a
                            type="button"
                            className="btn btn-secondary"
                            href="/adobts/create/<%= pet.id %>"
                          >
                            Nope
                          </a>
                          <a
                            href="/pets/adobt/<%= pet.id %>"
                            type="button"
                            className="btn btn-primary"
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
