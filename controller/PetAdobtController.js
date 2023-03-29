const { petAdobt, pet, adobt } = require("../models");

class PetAdobtController {
  static async getPetAdobts(req, res) {
    try {
      let petAdobts = await petAdobt.findAll({
        include: [pet, adobt],
      });

      //   res.json(petAdobts);
      res.render("petAdobts/index.ejs", { petAdobts });
    } catch (err) {
      res.json(err);
    }
  }

  static async create(req, res) {
    try {
      const { petId, adobtId } = req.body;

      let result = await petAdobt.create({
        petId: +petId,
        adobtId: +adobtId,
      });

      res.redirect("/petAdobts");
    } catch (err) {
      res.json(err);
    }
  }
}

module.exports = PetAdobtController;
