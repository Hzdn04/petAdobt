const { Router } = require("express");
const petRoute = Router();
const { PetController } = require("../controller");

pet.get("/", PetController.getPets);
pet.post("/create", PetController.create);
pet.get("/delete/:id", PetController.delete);
pet.post("/update/:id", PetController.update);

module.exports = petRoute;
