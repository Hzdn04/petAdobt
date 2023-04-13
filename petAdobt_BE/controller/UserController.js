const { user } = require("../models");
const { encrypt, decrypt } = require("../helpers/bcrypt");
const { tokenGenerate, tokenVerify } = require("../helpers/jsonwebtoken");

class UserController {
  static async getUsers(req, res) {
    try {
      let users = await user.findAll();

      res.status(200).json(users);
    } catch (error) {
      res.status(500).json(error);
    }
  }

  static async register(req, res) {
    try {
      const { username, email, password, name, age, address, phone, image } =
        req.body;

      const hashPass = encrypt(password);

      //   console.log(hashPass);
      let userRegister = await user.create({
        username,
        email,
        password: hashPass,
        name,
        age,
        address,
        phone,
        image,
      });

      res.status(200).json(userRegister);
    } catch (error) {
      res.status(500).json(error);
    }
  }

  static async login(req, res) {
    try {
      const { email, password } = req.body;

      const userLogin = await user.findOne({ where: { email } });

      if (userLogin) {
        if (decrypt(password, userLogin.password)) {
          const access_token = tokenGenerate(userLogin);

          res.status(200).json({ access_token });

          const verifyToken = tokenVerify(access_token);

          console.log(verifyToken);
        } else {
          res.status(403).json({ message: "Invalid credential" });
        }
      } else {
        res.status(404).json({ message: "User not found" });
      }
    } catch (error) {
      res.status(500).json(error);
    }
  }

  static async update(req, res) {
    try {
      const id = req.params.id;
      const { username, email, password, name, age, address, phone, image } =
        req.body;

      const hashPass = encrypt(password);

      const updateUser = user.update({
        username,
        email,
        password: hashPass,
        name,
        age,
        address,
        phone,
        image,
      });

      updateUser[0] === 1
        ? res.status(200).json({ message: "User has been updated!" })
        : res.status(400).json({ message: "User not updated" });
    } catch (error) {
      res.status(500).json(error);
    }
  }
}

module.exports = UserController;
