import React, { useState, useEffect } from "react";
import { Button, Modal } from "react-bootstrap";
import {
  deleteAdobted,
  getAdobteds,
  updatePaymentStatus,
} from "../../fetchs/adobtedFetch";
import { getPet } from "../../fetchs/petFetch";
import { getAccount } from "../../fetchs/userFetch";
import Loading from "../../helpers/Loading";
import { Link, useParams, useNavigate } from "react-router-dom";
import convertRp from "../../helpers/RpFormatter";
import Swal from "sweetalert2";

const ListAdobtedPage = () => {
  // const adobted = JSON.parse(localStorage.getItem('adobted'));

  const [adobteds, setAdobteds] = useState([]);

  const [totalPrice, setTotalPrice] = useState(0);

  const [user, setUser] = useState([]);
  const [payStatus, setPayStatus] = useState({});

  const [show, setShow] = useState(false);

  const [currentAdobted, setCurrentAdobted] = useState([]);

  const [selectedStatus, setSelectedStatus] = useState({ status: 1 });

  const navigate = useNavigate();
  const params = useParams();
  const handleClose = () => setShow(false);
  const handleShow = (id) => {
    const adobtedById = adobteds.find((adobted) => adobted.id === id);
    setCurrentAdobted(adobtedById);
    setShow(true);
  };

  // Paginate
  const [currentPage, setCurrentPage] = useState(1);
  const [adobtedsPerPage, setAdobtedsPerPage] = useState(5);
  //   const filtered = adobteds.filter((adobted) => adobted.userId === user.id);
  const filtered = adobteds;

  const indexOfLastAdobted = currentPage * adobtedsPerPage;
  const indexOfFirstAdobted = indexOfLastAdobted - adobtedsPerPage;
  const currentAdobteds = filtered.slice(
    indexOfFirstAdobted,
    indexOfLastAdobted
  );
  const totalPages = Math.ceil(adobteds.length / adobtedsPerPage);

  const handleClick = (page) => {
    setCurrentPage(page);
  };

  const renderPagination = () => {
    const pages = [];
    for (let i = 1; i <= totalPages; i++) {
      pages.push(
        <li
          key={i}
          className={`page-item ${currentPage === i ? "active" : null}`}
        >
          <a href="#" className="page-link" onClick={() => handleClick(i)}>
            {i}
          </a>
        </li>
      );
    }
    return pages;
  };

  useEffect(() => {
    const { id } = params;
    getAdobteds((result) => setAdobteds(result));
    getAccount((result) => setUser(result));
    // getAdobteds(id, (result) => {
    //   setPayStatus(result.status);
    // });
  }, []);

  const deleteHandler = (id) => {
    deleteAdobted(id);
    getAdobteds((result) => setAdobteds(result));
  };

  //   const statusHandler = (id) => {
  //     const paymentStatus = adobteds
  //       .filter((adobted) => adobted.id === id)
  //       .map((adobted) => adobted.status);

  //     console.log(paymentStatus);

  //     if (paymentStatus[0] === 1) {
  //       Swal.fire({
  //         title: "Changing Payment Status",
  //         text: "You will change this transaction status",
  //         icon: "warning",
  //         showCancelButton: true,
  //         showCloseButton: true,
  //         confirmButtonColor: "#3085d6",
  //         cancelButtonColor: "#d33",
  //         confirmButtonText: "Done",
  //         cancelButtonText: "Canceled",
  //       }).then(async (result) => {
  //         if (result.isConfirmed) {
  //           // Mengirim permintaan ke server atau basis data untuk mengubah status pembayaran
  //           const response = await updatePaymentStatus(id, 2); // Menggunakan nilai payStatus langsung di sini

  //           //   if (response.success) {
  //           //     // Jika pengiriman berhasil, tampilkan notifikasi
  //           // } else {
  //           //     // Jika terjadi kesalahan saat pengiriman, tampilkan pesan kesalahan
  //           //     Swal.fire("Error", "Failed to update payment status", "error");
  //           // }
  //           Swal.fire("Done", `Payment Complete ID ${id}`, "success");
  //           //   Swal.fire("Done", `Payment Complete ID ${id}`, "success");
  //           // Perbarui data setelah pengiriman berhasil atau gagal
  //           getAdobteds((result) => setAdobteds(result));
  //         }
  //       });
  //     }
  //   };

  const statusHandler = (id, selectedStatus) => {
    updatePaymentStatus(id, selectedStatus)
      .then(() => {
        getAdobteds((result) => setAdobteds(result));
        navigate("/");
      })
      .catch((error) => {
        console.log(error);
      });
  };

  return (
    <>
      {/* <Link to="/adobteds/create" className="btn btn-primary mb-2 mt-2">
        Add
      </Link> */}
      {/* <Link to="/pets" className="btn btn-primary mb-2 mt-2">
        Add
      </Link> */}
      <table className="table">
        <thead className="table-light">
          <tr>
            <td>No</td>
            <td>Pet</td>
            <td>Adobter</td>
            <td>Adobted Date</td>
            <td>Total</td>
            <td>Payment Status</td>
            <td>Action</td>
          </tr>
        </thead>
        <tbody>
          {currentAdobteds.length !== 0 ? (
            currentAdobteds.map((adobted, index) => {
              const { id, pet, user, adobt_date, total_price, status } =
                adobted;
              return (
                <tr key={id}>
                  <td>{index + 1}.</td>
                  <td>{pet.race}</td>
                  <td>{user.name}</td>
                  <td>{adobt_date}</td>
                  <td>{convertRp(total_price)}</td>
                  {status === 0 ? (
                    <td>
                      <Button onClick={() => handleShow(id)} variant="danger">
                        Canceled
                      </Button>
                    </td>
                  ) : status === 1 ? (
                    <td>
                      <Button onClick={() => handleShow(id)} variant="warning">
                        Pending
                      </Button>
                    </td>
                  ) : status === 2 ? (
                    <td>
                      <Button onClick={() => handleShow(id)} variant="primary">
                        Done
                      </Button>
                    </td>
                  ) : (
                    <td>
                      <Button onClick={() => handleShow(id)} variant="success">
                        Paid
                      </Button>
                    </td>
                  )}
                  <Modal key={id} show={show} onHide={handleClose}>
                    <Modal.Header closeButton>
                      <Modal.Title>Updating Payment Status</Modal.Title>
                    </Modal.Header>
                    <Modal.Body>
                      <div class="row my-2">
                        <div class="col-md-12">
                          <div class="form-group">
                            <label for="status">Payment Status</label>
                            <select
                              onChange={(e) =>
                                setSelectedStatus({
                                  status: e.target.value,
                                })
                              }
                              class="form-select"
                              name="status"
                              for="status"
                              id="status"
                            >
                              <option selected>Select Status</option>
                              {/* <option value={`${payStatus}`} selected>
                                {`${payStatus}`}
                              </option> */}
                              <option name="status" value={2}>
                                Done
                              </option>
                              <option name="status" value={3}>
                                Paid
                              </option>
                              <option name="status" value={1}>
                                Pending
                              </option>
                              <option name="status" value={0}>
                                Canceled
                              </option>
                            </select>
                          </div>
                        </div>
                      </div>
                      {/* <div class="row my-2">
                        <div class="col-md-12">
                          <div class="form-group">
                            <label for="race">Pet Race</label>
                            <input
                              type="text"
                              name="race"
                              value={currentAdobted.pet.race}
                              readOnly
                            />
                          </div>
                        </div>
                      </div> */}
                      {/* <div class="row my-2">
                        <div class="col-md-12">
                          <div class="form-group">
                            <label for="race">ID</label>
                            <input
                              type="text"
                              name="id"
                              value={currentAdobted.id}
                              readOnly
                            />
                          </div>
                        </div>
                      </div> */}
                    </Modal.Body>
                    <Modal.Footer>
                      <Button
                        variant="primary"
                        onClick={() =>
                          statusHandler(currentAdobted.id, selectedStatus)
                        }
                      >
                        Update
                      </Button>
                      <Button variant="secondary" onClick={handleClose}>
                        Close
                      </Button>
                    </Modal.Footer>
                  </Modal>
                  <td>
                    {/* <Link
                      to={`/adobteds/edit/${id}`}
                      className="btn btn-warning mx-1"
                    >
                      Edit
                    </Link> */}

                    <button
                      onClick={() => deleteHandler(+id)}
                      className="btn btn-danger"
                    >
                      Delete
                    </button>
                  </td>
                </tr>
              );
            })
          ) : (
            <Loading></Loading>
          )}
        </tbody>
        {/* <tfoot>
              <tr>
                <td colspan="5"></td>
                <td> {totalPrice} </td>
                <td> Totals </td>
              </tr>
        </tfoot> */}
      </table>
      <div className="col-12 mx-auto">
        <nav aria-label="Page navigation example">
          <ul className="pagination">
            <li
              className={`page-item ${currentPage === 1 ? "disabled" : null}`}
            >
              <a
                href="#"
                className="page-link"
                onClick={() => handleClick(currentPage - 1)}
              >
                Previous
              </a>
            </li>
            {renderPagination()}
            <li
              className={`page-item ${
                currentPage === totalPages ? "disabled" : null
              }`}
            >
              <a
                href="#"
                className="page-link"
                onClick={() => handleClick(currentPage + 1)}
              >
                Next
              </a>
            </li>
          </ul>
        </nav>
      </div>
    </>
  );
};

export default ListAdobtedPage;
