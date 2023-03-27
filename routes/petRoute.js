const pet = require("express").Router();
const { PetController } = require("../controller");

pet.get("/", PetController.getPets);

module.exports = pet;
