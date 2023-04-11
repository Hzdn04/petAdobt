const petadobt = require("express").Router();
const { PetAdobtController } = require("../controller");

petadobt.get("/", PetAdobtController.getPetAdobts); 
petadobt.get("/detail", PetAdobtController.getPetAdobtTotals); 
petadobt.get("/create", PetAdobtController.getPetAdobts);
petadobt.post("/create", PetAdobtController.create);
petadobt.get("/delete/:id", PetAdobtController.delete);

module.exports = petadobt;
