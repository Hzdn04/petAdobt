const user = require("express").Router();
const { UserController } = require("../controller");
const authentication = require("../middleware/authentication");
const upload = require("../middleware/multer");

user.post("/register", upload.single("image"), UserController.register);
user.post("/login", UserController.login);
user.get("/", authentication, UserController.getUsers);
user.get("/account", authentication, UserController.account);
user.put(
  "/update/:id",
  authentication,
  upload.single("image"),
  UserController.update
);
user.delete("/delete/:id", authentication, UserController.delete);

module.exports = user;
