const jwt = require("jsonwebtoken");
const secretCode = process.env.SECRET_CODE || "bebas";

const tokenGenerate = (data) => {
  const { id, username, email, name, age, address, phone, image } = data;

  return jwt.sign(
    { id, username, email, name, age, address, phone, image },
    secretCode
  );
};

const tokenVerify = (data) => {
  return jwt.verify(data, secretCode);
};

module.exports = {
  tokenGenerate,
  tokenVerify,
};
