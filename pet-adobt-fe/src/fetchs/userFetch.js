import React from "react";
import axios from "axios";
import Swal from "sweetalert2";

const URL = "http://localhost:3001/users";

const token = localStorage.getItem("access_token");

// const loginUser = async (user) => {
//     try {
//       let result = await axios({
//         method: "POST",
//         url: `${URL}/login`,
//         data: user,
//       });
//       const access_token = result.data.access_token;
//       localStorage.setItem("access_token", access_token);

//       loginCbHandler(true);
//       navigate("/");
//     } catch (err) {
//       console.log(err);
//     }
//   }

const getAccount = async (callback) => {
  try {
    const result = await axios({
      method: "GET",
      url: `${URL}/account`,
      headers: { access_token: token },
    });
    // console.log(user.data);
    callback(result.data);
  } catch (error) {
    console.log(error);
  }
};

const RegisterUser = async (user) => {
  try {
    let result = await axios({
      method: "POST",
      url: `${URL}/register`,
      data: user,
      headers: {
        "Content-Type": "multipart/form-data",
      },
    });
    Swal.fire("User has been added", "Success");
  } catch (err) {
    console.log(err);
  }
};

const editAccount = async (id, user) => {
  try {
    const result = await axios({
      method: "PUT",
      url: `${URL}/update/${id}`,
      data: user,
      headers: { access_token: token, "Content-Type": "multipart/form-data" },
    });
    Swal.fire(`"${user.name}" has been updated`, "Success");
    // console.log(result.data);
  } catch (error) {
    console.log(error);
  }
};

export {
  // loginUser,
  RegisterUser,
  getAccount,
  editAccount,
};
