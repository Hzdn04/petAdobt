const { Router } = require("express");
const petRoute = Router();
const { user } = require("../models");
const { PetController } = require("../controller");
const authentication = require("../middleware/authentication.js");

petRoute.get("/", PetController.getPets);
petRoute.get("/info/:id", authentication, PetController.petInfo);
// pet.get("/create", PetController.createPage);
// pet.get("/update/:id", PetController.updatePage);
// pet.get("/adobt/:id", PetController.adobtPage);
petRoute.post("/create", authentication, PetController.create);
petRoute.delete("/delete/:id", authentication, PetController.delete);
petRoute.put("/update/:id", authentication, PetController.update);

module.exports = petRoute;
