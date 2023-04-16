const petadobt = require("express").Router();
const { PetAdobtController } = require("../controller");
const authentication = require("../middleware/authentication");

petadobt.get("/", authentication, PetAdobtController.getPetAdobts);
petadobt.get("/detail", authentication, PetAdobtController.getPetAdobtTotals);
petadobt.get("/created", authentication, PetAdobtController.getPetAdobts);
petadobt.post("/create", authentication, PetAdobtController.create);
petadobt.delete("/delete/:id", authentication, PetAdobtController.delete);

module.exports = petadobt;
