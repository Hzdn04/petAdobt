const user = require("express").Router();
const { UserController } = require("../controller");

user.get("/", UserController.getUsers);
user.post("/register", UserController.register);
user.post("/login", UserController.login);

module.exports = user;
