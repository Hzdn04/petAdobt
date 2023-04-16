import axios from "axios";
import Swal from "sweetalert2";

const URL = "http://localhost:3001/pets";

const getPets = async (callback) => {
  try {
    const pets = await axios({
      method: "GET",
      url: `${URL}`,
    });
    // console.log(pets.data);
    callback(pets.data);
  } catch (error) {
    console.log(error);
  }
};

const addPet = async (pet) => {
  try {
    const result = await axios({
      method: "POST",
      url: `${URL}/create`,
      data: pet
    });
    Swal.fire(
<<<<<<< HEAD
      'Pet has been added',
=======
      'pet has been added',
>>>>>>> back-end
      'Success'
    )
    // console.log(result.data);
  } catch (error) {
    console.log(error);
  }
};

const editPet = async (id, pet) => {
  try {
    const result = await axios({
      method: "PUT",
<<<<<<< HEAD
      url: `${URL}/update/${id}`,
      data: pet
    });
    Swal.fire(
      `Pet "${pet.race}" has been updated`,
=======
      url: `${URL}/edit/${id}`,
      data: pet
    });
    Swal.fire(
      `pet "${pet.name}" has been updated`,
>>>>>>> back-end
      'Success'
    )
    // console.log(result.data);
  } catch (error) {
    console.log(error);
  }
};

const deletePet = async(id) => {
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
          url: `${URL}/delete/${id}`,
        })
        Swal.fire(
          'Deleted!',
          `pet ${id} has been deleted`,
          'Success'
        )
      }
    })
    
  } catch (error) {
    console.log(error);
  }
};

const getPet = async(id, callback) => {
  try {
    const result = await axios({
      method: "GET",
      url: `${URL}/info/${id}`,
    })

    callback(result.data)
  } catch (error) {
    console.log(error);
  }
};

export { getPets, addPet, editPet, deletePet, getPet };
