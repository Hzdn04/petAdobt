import React from 'react'
import { Outlet } from 'react-router-dom'

const UserPage = () => {

  const styles = {
    bottom:{
      height:"150px",
      width: "100%"
    }
  }
  
  return (
    <div className="container" data-aos="fade-up" data-aos-delay="100">
        <Outlet></Outlet>
        <div className='bottom' style={styles.bottom}></div>
    </div>
  )
}

export default UserPage