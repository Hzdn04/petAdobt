import React from "react";
import { Link } from "react-router-dom";

const HomePage = (props) => {

  const {loginStatus, loginCbHandler} = props

  const styles = {
    hero: {
      backgroundImage: `url('${process.env.PUBLIC_URL}/images/bg_1.jpg')`,
    },
  };
  return (
    // <div className="row py-2">
    //   <div
    //     id="carouselExampleRide"
    //     class="carousel slide col-lg-7 mb-2"
    //     data-bs-ride="true"
    //   >
    //     <div class="carousel-inner">
    //       <div class="carousel-item active">
    //         <img
    //           src="https://images.unsplash.com/photo-1622659097972-68f1d8c1829f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=871&q=80"
    //           class="d-block w-100"
    //           alt="..."
    //         />
    //         <div class="carousel-caption d-none d-md-block">
    //           <h5>Wonderfull Football</h5>
    //           <p>
    //             Some representative placeholder content for the first slide.
    //           </p>
    //         </div>
    //       </div>
    //       <div class="carousel-item">
    //         <img
    //           src="https://images.unsplash.com/photo-1600077063877-22118d6290eb?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80"
    //           class="d-block w-100"
    //           alt="..."
    //         />
    //       </div>
    //       <div class="carousel-item">
    //         <img
    //           src="https://images.unsplash.com/photo-1526232761682-d26e03ac148e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=829&q=80"
    //           class="d-block w-100"
    //           alt="..."
    //         />
    //       </div>
    //     </div>
    //     <button
    //       class="carousel-control-prev"
    //       type="button"
    //       data-bs-target="#carouselExampleRide"
    //       data-bs-slide="prev"
    //     >
    //       <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    //       <span class="visually-hidden">Previous</span>
    //     </button>
    //     <button
    //       class="carousel-control-next"
    //       type="button"
    //       data-bs-target="#carouselExampleRide"
    //       data-bs-slide="next"
    //     >
    //       <span class="carousel-control-next-icon" aria-hidden="true"></span>
    //       <span class="visually-hidden">Next</span>
    //     </button>
    //   </div>
    //   <div className="col-lg-5">
    //     <h4 className="bg-success rounded p-1 px-2 text-white">News</h4>
    //     <div class="card mb-3" style={styles.card}>
    //       <div class="row g-0">
    //         <div class="col-md-4">
    //           <img
    //             src="https://images.unsplash.com/photo-1598880513655-d1c6d4b2dfbf?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1974&q=80"
    //             class="img-fluid rounded-start"
    //             alt="..."
    //           />
    //         </div>
    //         <div class="col-md-8">
    //           <div class="card-body">
    //             <h5 class="card-title">Competition</h5>
    //             <p class="card-text">
    //               This is a wider card with supporting text below .
    //             </p>
    //           </div>
    //         </div>
    //       </div>
    //     </div>
    //   </div>
    // </div>
    <>
      <section id="hero">
        <div class="hero-container" data-aos="zoom-in" data-aos-delay="100">
          <h1>Welcome to petAdobt</h1>
          <h2>
          Highest Quality Care For Pets You'll Love
          </h2>
          <Link to="/" class="btn-get-started">
            Get Adobt
          </Link>
        </div>
      </section>
    </>
  );
};

export default HomePage;
