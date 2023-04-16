import React, { useState, useEffect } from "react";
import { deleteAdobted, getAdobteds } from "../../fetchs/adobtedFetch";
import { getPet } from "../../fetchs/petFetch";
import { getAccount } from "../../fetchs/userFetch";
import Loading from "../../helpers/Loading";
import { Link } from "react-router-dom";

const ListAdobtedPage = () => {

  // const adobted = JSON.parse(localStorage.getItem('adobted'));
  
  const [adobteds, setAdobteds] = useState([]);

  useEffect(() => {
    getAdobteds((result) => setAdobteds(result));
    
  }, []);

  const deleteHandler = (id) => {
    deleteAdobted(id)
    getAdobteds(result => setAdobteds(result))
  }

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
          {adobteds.length !== 0 ? 
          (
            adobteds.map((adobted, index) => {
              const { id, pet, user, adobt_date, total_price } = adobted;
              return (
                <tr key={id}>
                  <td>{index + 1}</td>
                  <td>{pet.race}</td>
                  <td>{user.name}</td>
                  <td>{adobt_date}</td>
                  <td>{user.address}</td>
                  <td>{total_price}</td>
                  <td>
                    {/* <Link to={`/adobteds/edit/${id}`} className="btn btn-warning mx-1">
                      Edit
                    </Link> */}
                    
                    <button onClick={() => deleteHandler(+id)} className="btn btn-danger">Delete</button>
                  </td>
                </tr>
              );
            })
          ) : 
          (
            <Loading></Loading>
          )}
        </tbody>
      </table>
    </>
  );
};

export default ListAdobtedPage;
