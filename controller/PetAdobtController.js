const { petAdobt, pet, adobt } = require("../models");

class PetAdobtController {
  static async getPetAdobts(req, res) {
    try {
      let results = await petAdobt.findAll({
        include: [pet, adobt],
      });

      res.json(results);
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

      res.json(result);
    } catch (err) {
      res.json(err);
    }
  }
}

module.exports = PetAdobtController;
