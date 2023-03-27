const adobt = require("express").Router();
const { AdobtController } = require("../controller");

adobt.get("/", AdobtController.getAdobts);

module.exports = adobt;
