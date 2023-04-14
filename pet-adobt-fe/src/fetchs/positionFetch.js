import axios from 'axios'
import Swal from "sweetalert2";

const URL = 'http://localhost:3001/positions'

const getPositions = async (callback) => {
    try {
        const positions = await axios({
            method: "GET",
            url: `${URL}`
        })
        // console.log(positions);
        callback(positions.data);
    } catch (error) {
        console.log(error);
    }
}

const addPosition = async (position) => {
    try {
      const result = await axios({
        method: "POST",
        url: `${URL}/create`,
        data: position
      });
      Swal.fire(
        'position has been added',
        'Success'
      )
      // console.log(result.data);
    } catch (error) {
      console.log(error);
    }
  };
  
  const editPosition = async (id, position) => {
    try {
      const result = await axios({
        method: "PUT",
        url: `${URL}/edit/${id}`,
        data: position
      });
      Swal.fire(
        `position "${position.name}" has been updated`,
        'Success'
      )
      // console.log(result.data);
    } catch (error) {
      console.log(error);
    }
  };
  
  const deletePosition = async(id) => {
    try {
      Swal.fire({
        title: 'Are you sure?',
        text: "You won't be able to revert this!",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Yes, delete it!'
      }).then(async (result) => {
        if (result.isConfirmed) {
          let result = await axios({
            method: "DELETE",
            url: `${URL}/remove/${id}`,
          })
          Swal.fire(
            'Deleted!',
            `position ${id} has been deleted`,
            'Success'
          )
        }
      })
      
    } catch (error) {
      console.log(error);
    }
  };
  
  const getPosition = async(id, callback) => {
    try {
      const result = await axios({
        method: "GET",
        url: `${URL}/get/${id}`,
      })
  
      callback(result.data)
    } catch (error) {
      console.log(error);
    }
  };

export {
    getPositions, addPosition, editPosition, deletePosition, getPosition
}