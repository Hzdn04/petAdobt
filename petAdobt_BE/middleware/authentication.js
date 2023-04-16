const { tokenVerify } = require("../helpers/jsonwebtoken");

const authentication = (req, res, next) => {
  console.log("Middleware Authentication");
  const access_token = req.headers.access_token;

  //   console.log(verifyToken);

  if (access_token) {
    console.log("Token found!");
    try {
      let verifyToken = tokenVerify(access_token);
      //   console.log(verifyToken);
      req.userData = verifyToken;
      next();
    } catch (error) {
      res.status(401).json({
        message: "Token not authenticated!",
      });
    }
  } else {
    res.status(404).json({
      message: "Harap login terlebih dahulu",
    });
  }
};

module.exports = authentication;
