const { Router } = require("express");
const pet = Router();
const { PetController } = require("../controller");

pet.get("/", PetController.getPets);
pet.get("/create", PetController.createPage);
pet.post("/create", PetController.create);
pet.get("/delete/:id", PetController.delete);
pet.post("/update/:id", PetController.update);

module.exports = pet;
