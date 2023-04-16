import React, { useEffect } from "react";
import { Routes, Route, useNavigate } from "react-router-dom";
import {
  HomePage,
  PetPage,
  ListPetPage,
  CreatePetPage,
  EditPetPage,
  AdobtedPage,
  ListAdobtedPage,
  CreateAdobtedPage,
  EditAdobtedPage,
  UserPage,
  LoginPage,
  RegisterPage,
  ProfilePage,
} from "../pages";
import About from "./About";

const Main = (props) => {
  const navigate = useNavigate();
  const { loginStatus, loginCbHandler } = props;

  useEffect(() => {
    loginStatus && navigate("/");
  }, [loginStatus]);

  const styles = {
    main: {
      height: "100vh",
    },
  };
  return (
    <div className="main" style={styles.main}>
      <Routes>
        <Route path="" element={<HomePage />}></Route>

        <Route path="pets" element={<PetPage />}>
          <Route path="" element={<ListPetPage />}></Route>
          <Route path="create" element={<CreatePetPage />}></Route>
          <Route path="update">
            <Route path=":id" element={<EditPetPage />}></Route>
          </Route>
        </Route>

        <Route path="adobteds" element={<AdobtedPage />}>
          <Route path="" element={<ListAdobtedPage />}></Route>
          <Route path="create" element={<CreateAdobtedPage />}></Route>
          <Route path="edit">
            <Route path=":id" element={<EditAdobtedPage />}></Route>
          </Route>
        </Route>

        <Route path="profile" element={<UserPage />}>
          <Route path="" element={<ProfilePage />}></Route>
        </Route>

        {!loginStatus && (
          <Route
            path="login"
            element={<LoginPage loginStatus={loginStatus} />}
          ></Route>
        )}

        <Route path="register" element={<RegisterPage />}></Route>

        <Route path="about" element={<About />}></Route>
      </Routes>
    </div>
  );
};

export default Main;
