import React, { useState, useEffect } from "react";
import { deleteAdobted, getAdobteds } from "../../fetchs/adobtedFetch";
import { getPet } from "../../fetchs/petFetch";
import { deleteUser, getUsers } from "../../fetchs/userFetch";
import Loading from "../../helpers/Loading";
import { Link, useNavigate } from "react-router-dom";
import convertRp from "../../helpers/RpFormatter";
import Swal from "sweetalert2";

const UsersPage = () => {
  // const adobted = JSON.parse(localStorage.getItem('adobted'));

  const [adobteds, setAdobteds] = useState([]);

  const [totalPrice, setTotalPrice] = useState(0);

  const [users, setUsers] = useState([]);

  const navigate = useNavigate();

  // Paginate
  const [currentPage, setCurrentPage] = useState(1);
  const [usersPerPage, setUsersPerPage] = useState(5);
  //   const filtered = adobteds.filter((adobted) => adobted.userId === user.id);
  const filtered = users.filter((user) => user.role === 2);

  const indexOfLastUser = currentPage * usersPerPage;
  const indexOfFirstUser = indexOfLastUser - usersPerPage;
  const currentUsers = filtered.slice(indexOfFirstUser, indexOfLastUser);
  const totalPages = Math.ceil(users.length / usersPerPage);

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
    getUsers((result) => setUsers(result));
  }, []);

  const deleteHandler = (id) => {
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
        deleteUser(id);
        getUsers((result) => setUsers(result));
        Swal.fire("Deleted!", `Adobted ${id} has been deleted`, "Success");
        navigate("/profile/users");
      }
    });
  };

  const styles = {
    photo: {
      height: "100px",
      //   weight: "100px",
    },
  };

  return (
    <>
      {
        <div className="container">
          <h4 className="text-center mt-3">Manage Users</h4>
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
                <td>Photo</td>
                <td>Name</td>
                <td>Username</td>
                <td>Email</td>
                <td>Age</td>
                <td>Address</td>
                <td>Phone</td>
                <td>Action</td>
              </tr>
            </thead>
            <tbody>
              {currentUsers.length !== 0 ? (
                currentUsers.map((user, index) => {
                  const {
                    id,
                    username,
                    email,
                    name,
                    age,
                    address,
                    phone,
                    image,
                    role,
                  } = user;

                  return (
                    <tr key={id}>
                      <td>{index + 1}.</td>
                      <td>
                        <img src={image} alt="profile_p" style={styles.photo} />
                      </td>
                      <td>{name}</td>
                      <td>{username}</td>
                      <td>{email}</td>
                      <td>{age}</td>
                      <td>{address}</td>
                      <td>{phone}</td>
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
                  className={`page-item ${
                    currentPage === 1 ? "disabled" : null
                  }`}
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
        </div>
      }
    </>
  );
};

export default UsersPage;
