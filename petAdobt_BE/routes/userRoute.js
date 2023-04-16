const user = require("express").Router();
const { UserController } = require("../controller");
const authentication = require("../middleware/authentication");

user.post("/register", UserController.register);
user.post("/login", UserController.login);
user.get("/", authentication, UserController.getUsers);
user.get("/account/:id", authentication, UserController.account);
user.put("/update/:id", authentication, UserController.update);
user.delete("/delete/:id", authentication, UserController.delete);

module.exports = user;
