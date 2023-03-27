const { Router } = require("express");
const petRoute = Router();
const { PetController } = require("../controller");

petRoute.get("/", PetController.getPets);
petRoute.get("/create", PetController.createPage);

module.exports = petRoute;
