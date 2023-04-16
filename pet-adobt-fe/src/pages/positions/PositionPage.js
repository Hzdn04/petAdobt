import React, { useState, useEffect } from "react";
import { Outlet } from 'react-router-dom'

const PositionPage = () => {

  return (
    <div className="container">
      <h4 className="text-center mt-3">Positions Management</h4>
      
      <Outlet></Outlet>
    </div>
  );
};

export default PositionPage;
