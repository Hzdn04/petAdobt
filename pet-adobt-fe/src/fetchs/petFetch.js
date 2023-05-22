import axios from "axios";
import Swal from "sweetalert2";

const URL = "http://localhost:3001/pets";

const token = localStorage.getItem("access_token");

const getPets = async (callback) => {
  try {
    const pets = await axios({
      method: "GET",
      url: `${URL}`,
      headers: { access_token: token },
    });
    // console.log(pets.headers);
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
      data: pet,
      headers: { access_token: token, "Content-Type": "multipart/form-data" },
    });
    Swal.fire("Pet has been added", "Success");
    // console.log(result.data);
  } catch (error) {
    console.log(error);
  }
};

const editPet = async (id, pet) => {
  try {
    const result = await axios({
      method: "PUT",
      url: `${URL}/update/${id}`,
      data: pet,
      headers: { access_token: token, "Content-Type": "multipart/form-data" },
    });
    Swal.fire(`Pet "${pet.name}" has been updated`, "Success");
    // console.log(result.data);
  } catch (error) {
    console.log(error);
  }
};

const deletePet = async (id) => {
  try {
    let result = await axios({
      method: "DELETE",
      url: `${URL}/delete/${id}`,
      headers: { access_token: token },
    });
  } catch (error) {
    console.log(error);
  }
};

const getPet = async (id, callback) => {
  try {
    const result = await axios({
      method: "GET",
      url: `${URL}/info/${id}`,
      headers: { access_token: token },
    });

    callback(result.data);
  } catch (error) {
    console.log(error);
  }
};

export { getPets, addPet, editPet, deletePet, getPet };
