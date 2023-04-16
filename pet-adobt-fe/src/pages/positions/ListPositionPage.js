import React, { useState, useEffect } from "react";
import { deletePosition, getPositions } from "../../fetchs/positionFetch";
import Loading from "../../helpers/Loading";
import { Link } from "react-router-dom";

const ListPositionPage = () => {
  const [positions, setPositions] = useState([]);

  useEffect(() => {
    getPositions((result) => setPositions(result));
  }, []);

  const deleteHandler = (id) => {
    deletePosition(id)
    getPositions(result => setPositions(result))
  }

  return (
    <>
      <Link to="/positions/create" className="btn btn-primary mb-2 mt-2">
        Add
      </Link>
      <table className="table">
        <thead className="table-light">
          <tr>
            <td>No</td>
            <td>Name</td>
            <td>Position</td>
            <td>Skill</td>
            <td>Action</td>
          </tr>
        </thead>
        <tbody>
          {positions.length !== 0 ? 
          (
            positions.map((position, index) => {
              const { id, name, position_player, skill } = position;
              return (
                <tr key={id}>
                  <td>{index + 1}</td>
                  <td>{name}</td>
                  <td>{position_player}</td>
                  <td>{skill}</td>
                  <td>
                    <Link to={`/positions/edit/${id}`} className="btn btn-warning mx-1">
                      Edit
                    </Link>
                    
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

export default ListPositionPage;
