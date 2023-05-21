import React, { useState, useEffect } from "react";
import { deleteAdobted, getAdobteds } from "../../fetchs/adobtedFetch";
import { getPet } from "../../fetchs/petFetch";
import { getAccount } from "../../fetchs/userFetch";
import Loading from "../../helpers/Loading";
import { Link } from "react-router-dom";
import convertRp from "../../helpers/RpFormatter";

const ListAdobtedPage = () => {
  // const adobted = JSON.parse(localStorage.getItem('adobted'));

  const [adobteds, setAdobteds] = useState([]);

  const [totalPrice, setTotalPrice] = useState(0);

  const [user, setUser] = useState([]);

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
    getAdobteds((result) => setAdobteds(result));
    getAccount((result) => setUser(result));
  }, []);

  const deleteHandler = (id) => {
    deleteAdobted(id);
    getAdobteds((result) => setAdobteds(result));
  };

  return (
    <>
      {/* <Link to="/adobteds/create" className="btn btn-primary mb-2 mt-2">
        Add
      </Link> */}
      <Link to="/pets" className="btn btn-primary mb-2 mt-2">
        Add
      </Link>
      <table className="table">
        <thead className="table-light">
          <tr>
            <td>No</td>
            <td>Pet</td>
            <td>adobted</td>
            <td>adobted date</td>
            <td>address</td>
            <td>total</td>
            <td>Action</td>
          </tr>
        </thead>
        <tbody>
          {currentAdobteds.length !== 0 ? (
            currentAdobteds.map((adobted, index) => {
              const { id, pet, user, adobt_date, total_price } = adobted;
              return (
                <tr key={id}>
                  <td>{index + 1}.</td>
                  <td>{pet.race}</td>
                  <td>{user.name}</td>
                  <td>{adobt_date}</td>
                  <td>{user.address}</td>
                  <td>{convertRp(total_price)}</td>
                  <td>
                    {/* <Link to={`/adobteds/edit/${id}`} className="btn btn-warning mx-1">
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
