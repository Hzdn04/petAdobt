const adobt = require("express").Router();
const { AdobtController } = require("../controller");

adobt.get("/", AdobtController.getAdobts);
adobt.get("/create/:id", AdobtController.createPage);
adobt.get("/update/:id", AdobtController.updatePage);
adobt.post("/create", AdobtController.create);
adobt.get("/delete/:id", AdobtController.delete);
adobt.post("/update/:id", AdobtController.update);

module.exports = adobt;
