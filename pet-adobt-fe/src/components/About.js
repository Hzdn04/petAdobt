import React from "react";

const About = () => {
  return (
    <div>
      <section id="about">
        <div class="container" data-aos="fade-up">
          <div class="row about-container">
            <div class="col-lg-6 content order-lg-1 order-2">
              <h2 class="title mb-4">Few Words About Us</h2>

              <div class="icon-box" data-aos="fade-up" data-aos-delay="100">
                <div class="icon">
                  <i class="bi bi-briefcase"></i>
                </div>
                <h4 class="title">
                  <a href="">Customer Supports</a>
                </h4>
                <p class="description">
                Far far away, behind the word mountains, far from the countries.
                </p>
              </div>

              <div class="icon-box" data-aos="fade-up" data-aos-delay="200">
                <div class="icon">
                  <i class="bi bi-card-checklist"></i>
                </div>
                <h4 class="title">
                  <a href="">Emergency Services</a>
                </h4>
                <p class="description">
                Far far away, behind the word mountains, far from the countries.
                </p>
              </div>

              <div class="icon-box" data-aos="fade-up" data-aos-delay="300">
                <div class="icon">
                  <i class="bi bi-binoculars"></i>
                </div>
                <h4 class="title">
                  <a href="">Care Advices</a>
                </h4>
                <p class="description">
                Far far away, behind the word mountains, far from the countries.
                </p>
              </div>
              <div class="icon-box" data-aos="fade-up" data-aos-delay="300">
                <div class="icon">
                  <i class="bi bi-binoculars"></i>
                </div>
                <h4 class="title">
                  <a href="">Veterinary Help</a>
                </h4>
                <p class="description">
                Far far away, behind the word mountains, far from the countries.
                </p>
              </div>
            </div>

            <div
              class="col-lg-6 background order-lg-2 order-1"
              data-aos="fade-left"
              data-aos-delay="100"
            ></div>
          </div>
        </div>
      </section>
    </div>
  );
};

export default About;
