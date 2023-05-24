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
<<<<<<< HEAD

petadobt.put(
    "/cancel/:id",
    authentication,
    PetAdobtController.cancelAdobt
  );

=======
petadobt.put(
  "/updatePaymentStatus/:id",
  authentication,
  PetAdobtController.updatePaymentStatus
);
>>>>>>> back-end
petadobt.delete("/delete/:id", authentication, PetAdobtController.delete);

module.exports = petadobt;
