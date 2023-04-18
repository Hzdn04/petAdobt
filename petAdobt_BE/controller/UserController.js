const { user, pet, petAdobt } = require("../models");
const { encrypt, decrypt } = require("../helpers/bcrypt");
const { tokenGenerate, tokenVerify } = require("../helpers/jsonwebtoken");

class UserController {
  static async getUsers(req, res) {
    try {
      let users = await user.findAll({
        order: [["id", "ASC"]],
      });

      res.status(200).json(users);
    } catch (error) {
      res.status(500).json(error);
    }
  }

  static async account(req, res) {
    try {
      const id = +req.userData.id;
      let userProfile = await user.findByPk(id);

      userProfile
        ? res.status(200).json(userProfile)
        : res.status(404).json({ message: `User not found` });
    } catch (error) {
      req.status(500).json(error);
    }
  }

  static async transacHistory(req, res) {
    try {
      let transaction = await petAdobt.findAll({ where: { userId } });
    } catch (error) {
      res.status(500).json(error);
    }
  }

  static async register(req, res) {
    try {
      const { username, email, password, name, age, address, phone, role } =
        req.body;

      const image =
        req.protocol + `://` + req.get("host") + "/assets/" + req.file.filename;

      //   console.log(image);
      //   console.log(req.get("host"));

      let userRegister = await user.create({
        username,
        email,
        password,
        name,
        age,
        address,
        phone,
        image,
        role,
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

      //   res.json(userLogin);
      //   if (decrypt(password, userLogin)) {
      //     res.json(userLogin);
      //   } else {
      //     res.json({ message: "salah" });
      //   }

      if (userLogin) {
        if (decrypt(password, userLogin.password)) {
          const access_token = tokenGenerate(userLogin);
          //   res.status(200).json(userLogin);
          res.status(200).json({ access_token });

          const verifyToken = tokenVerify(access_token);
          console.log(verifyToken);
          //   console.log(access_token);
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
      const { username, email, password, name, age, address, phone, role } =
        req.body;

      const image =
        req.protocol + `://` + req.get("host") + "/assets/" + req.file.filename;

      const hashPass = encrypt(password);

      const updateUser = await user.update(
        {
          username,
          email,
          password: hashPass,
          name,
          age,
          address,
          phone,
          image,
          role,
        },
        {
          where: { id },
        }
      );

      //   console.log(updateUser);

      updateUser[0] === 1
        ? res.status(200).json({ message: "User has been updated!" })
        : res.status(400).json({ message: "User not updated" });
    } catch (error) {
      res.status(500).json(error);
    }
  }

  static async delete(req, res) {
    const id = +req.params.id;
    let deleteUser = await user.destroy({ where: { id } });

    deleteUser === 1
      ? res.status(200).json({ message: `User has been deleted` })
      : res.status(400).json({ message: `User not deleted` });
  }
}

module.exports = UserController;
