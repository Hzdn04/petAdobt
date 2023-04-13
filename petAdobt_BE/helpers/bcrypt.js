const bcrypt = require("bcrypt");
const salt = process.env.SALT_ROUND || 5;

const encrypt = (pass) => {
  return bcrypt.hashSync(String(pass), salt);
};

const decrypt = (password, hashedPassword) => {
  return bcrypt.compareSync(password, String(hashedPassword));
};

module.exports = {
  encrypt,
  decrypt,
};
