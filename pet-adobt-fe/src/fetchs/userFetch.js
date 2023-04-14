import React from 'react'
import axios from "axios";
import Swal from "sweetalert2";

const URL = "http://localhost:3001/users";

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

  const RegisterUser = async (user) => {
    try {
      let result = await axios({
        method: "POST",
        url: `${URL}/register`,
        data: user,
      });
      Swal.fire(
        'User has been added',
        'Success'
      )

    } catch (err) {
      console.log(err);
    }
  };

export { 
  // loginUser, 
  RegisterUser };