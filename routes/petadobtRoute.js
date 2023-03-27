const petadobt = require("express").Router();
const { PetAdobtController } = require("../controller");

petadobt.get("/", PetAdobtController.getPetAdobts);
petadobt.post("/create", PetAdobtController.create);

module.exports = petadobt;
