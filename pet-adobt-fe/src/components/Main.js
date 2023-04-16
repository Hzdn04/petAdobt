import React, { useEffect } from "react";
import { Routes, Route, useNavigate } from "react-router-dom";
import { 
   HomePage,
   PetPage, ListPetPage, CreatePetPage, EditPetPage,
   PositionPage, ListPositionPage, CreatePositionPage, EditPositionPage, 
   LoginPage, RegisterPage, ProfilePage
  } from "../pages";
import About from "./About";

const Main = (props) => {
  const navigate = useNavigate();
  const { loginStatus, loginCbHandler } = props;

  useEffect(() => {
    loginStatus && navigate("/");
  }, [loginStatus])

  const styles ={
    main:{
      height: "100vh",
    }
  }
  return (
    <div className="main" style={styles.main} >
      <Routes>
        <Route path="" element={<HomePage/>}></Route>
        
        <Route path="pets" element={<PetPage/>}>
          <Route path="" element={<ListPetPage/>}></Route>
          <Route path="create" element={<CreatePetPage/>}></Route>
          <Route path="update">
            <Route path=":id" element={<EditPetPage/>}></Route>
          </Route>
        </Route>

        <Route path="positions" element={<PositionPage/>}>
        <Route path="" element={<ListPositionPage/>}></Route>
          <Route path="create" element={<CreatePositionPage/>}></Route>
          <Route path="edit">
            <Route path=":id" element={<EditPositionPage/>}></Route>
          </Route>
        </Route>

          { !loginStatus &&
            <Route path="login" element={<LoginPage loginStatus={loginStatus}/>}></Route>
          }
        
        <Route path="profile">
          <Route path=":id" element={<ProfilePage/>}></Route>
        </Route>
        
        <Route path="register" element={<RegisterPage/>}></Route>
        
        <Route path="about" element={<About/>}></Route>
      </Routes>
    </div>
  );
};

export default Main;
