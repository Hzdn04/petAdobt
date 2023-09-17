import React from "react";

const Footer = () => {
  return (
    <div>
      <footer id="footer" className="footer fixed-bottom">
        <div class="footer-top">
          <div class="container"></div>
        </div>

        <div class="container">
          <div class="copyright">
            &copy; Copyright <strong>petAdobt</strong>. All Rights Reserved
          </div>
          <div class="credits">
            Designed by
            <a className="link" href="https://www.instagram.com/h_zdn04/">
              Hafiz
            </a>
            and
            <a className="link" href="https://www.instagram.com/kmonding/">
              Kevinsy
            </a>
          </div>
        </div>
      </footer>
    </div>
  );
};

export default Footer;
