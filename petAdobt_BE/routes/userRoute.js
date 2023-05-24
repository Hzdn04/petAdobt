const user = require("express").Router();
const { UserController } = require("../controller");
const authentication = require("../middleware/authentication");
const upload = require("../middleware/multer");

user.post("/register", UserController.register);
user.post("/login", UserController.login);
user.get("/", UserController.getUsers);
user.get("/account", authentication, UserController.account);
user.put(
  "/update/:id",
  authentication,
  upload.single("image"),
  UserController.update
);

user.put(
  "/edit/:id",
  authentication,
  UserController.edit
);

user.put(
  "/change/:id",
  authentication,
  UserController.changePassword
);

user.put(
  "/upload/:id",
  authentication,
  upload.single("image"),
  UserController.uploadImage
);

user.delete("/delete/:id", authentication, UserController.delete);

module.exports = user;
