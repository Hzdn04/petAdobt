const petadobt = require("express").Router();
const { PetAdobtController } = require("../controller");
const authentication = require("../middleware/authentication");

petadobt.get("/", authentication, PetAdobtController.getPetAdobts);
petadobt.get(
  "/user/:userId",
  authentication,
  PetAdobtController.getPetAdobtsByUser
);
petadobt.get("/detail", authentication, PetAdobtController.getPetAdobtTotals);
petadobt.get("/created", authentication, PetAdobtController.getPetAdobts);
petadobt.post("/create", authentication, PetAdobtController.create);
petadobt.put(
  "/updatePaymentStatus/:id",
  authentication,
  PetAdobtController.updatePaymentStatus
);
petadobt.delete("/delete/:id", authentication, PetAdobtController.delete);

module.exports = petadobt;
