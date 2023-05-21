const { Router } = require("express");
const petRoute = Router();
const { PetController } = require("../controller");
const authentication = require("../middleware/authentication.js");
const upload = require("../middleware/multer");

petRoute.get("/", authentication, PetController.getPets);
petRoute.get("/info/:id", authentication, PetController.petInfo);
// pet.get("/create", PetController.createPage);
// pet.get("/update/:id", PetController.updatePage);
// pet.get("/adobt/:id", PetController.adobtPage);
petRoute.post(
  "/create",
  authentication,
  upload.single("image"),
  PetController.create
);
petRoute.delete("/delete/:id", authentication, PetController.delete);
petRoute.put(
  "/update/:id",
  authentication,
  upload.single("image"),
  PetController.update
);

module.exports = petRoute;
