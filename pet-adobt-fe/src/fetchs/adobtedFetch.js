import axios from "axios";
import Swal from "sweetalert2";

const URL = "http://localhost:3001/petadobts";

const token = localStorage.getItem("access_token");

const getAdobteds = async (callback) => {
  try {
    const adobteds = await axios({
      method: "GET",
      url: `${URL}`,
      headers: { access_token: token },
    });
    // console.log(adobteds);
    callback(adobteds.data);
  } catch (error) {
    console.log(error);
  }
};

const addAdobted = async (adobted) => {
  try {
    const result = await axios({
      method: "POST",
      url: `${URL}/create`,
      data: adobted,
      headers: { access_token: token },
    });
    Swal.fire(`Adobted has been added`, "Success");

    // console.log(result.data);
  } catch (error) {
    console.log(error);
  }
};

const editAdobted = async (id, adobted) => {
  try {
    const result = await axios({
      method: "PUT",
      url: `${URL}/edit/${id}`,
      data: adobted,
      headers: { access_token: token },
    });
    Swal.fire(`Adobted "${adobted.name}" has been updated`, "Success");
    // console.log(result.data);
  } catch (error) {
    console.log(error);
  }
};

const updatePaymentStatus = async (id, status) => {
  try {
    console.log(id, +status);
    const result = await axios({
      method: "PUT",
      url: `${URL}/updatePaymentStatus/${id}`,
      data: status,
      headers: {
        access_token: token,
        "Content-Type": "application/x-www-form-urlencoded",
      },
    });

    Swal.fire(`Payment status changed to "${status}"`, "Success");
  } catch (error) {
    console.log(error);
  }
};

const deleteAdobted = async (id) => {
  try {
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
        let result = await axios({
          method: "DELETE",
          url: `${URL}/delete/${id}`,
          headers: { access_token: token },
        });
        Swal.fire("Deleted!", `Adobted ${id} has been deleted`, "Success");
      }
    });
  } catch (error) {
    console.log(error);
  }
};

const getAdobted = async (id, callback) => {
  try {
    const result = await axios({
      method: "GET",
      url: `${URL}/get/${id}`,
      headers: { access_token: token },
    });

    callback(result.data);
  } catch (error) {
    console.log(error);
  }
};

export {
  getAdobteds,
  addAdobted,
  editAdobted,
  deleteAdobted,
  getAdobted,
  updatePaymentStatus,
};
