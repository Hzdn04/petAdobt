import React from 'react'
import { Outlet } from 'react-router-dom'

const PetPage = () => {
  return (
    <div className="container" data-aos="fade-up" data-aos-delay="100">
      <h4 className="text-center mt-3">Pets Collection</h4>
      
      <Outlet></Outlet>
      
    </div>
  )
}

export default PetPage