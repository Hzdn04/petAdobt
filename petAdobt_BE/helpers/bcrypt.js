const bcrypt = require("bcrypt");
const saltRound = +process.env.SALT_ROUND || 5;

const encrypt = (data) => {
  return bcrypt.hashSync(String(data), saltRound);
};

const decrypt = (data, hashPwd) => {
  return bcrypt.compareSync(String(data), hashPwd);
};

module.exports = {
  encrypt,
  decrypt,
};
