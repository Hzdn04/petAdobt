import React, { useState, useEffect } from "react";
import { Outlet } from 'react-router-dom'

const AdobtedPage = () => {

  return (
    <div className="container">
      <h4 className="text-center mt-3">Adobted Transaction</h4>
      
      <Outlet></Outlet>
    </div>
  );
};

export default AdobtedPage;
