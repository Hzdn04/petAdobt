const user = require("express").Router();
const { UserController } = require("../controller");

user.get("/", UserController.getUsers);
user.get("/account/:id", UserController.account);
user.post("/register", UserController.register);
user.post("/login", UserController.login);
user.put("/update/:id", UserController.update);
user.delete("/delete/:id", UserController.delete);

module.exports = user;
