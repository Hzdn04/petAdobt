const { pet, adobt } = require("../models");

class PetController {
  static async getPets(req, res) {
    try {
      let pets = await pet.findAll({
        include: [adobt],
      });

      res.json(pets);
    } catch (err) {
      res.json(err);
    }
  }
  static createPage(req, res) {}
  static create(req, res) {
    
  }
  static delete(req, res) {}
  static updatePage(req, res) {}
  static update(req, res) {}
}

module.exports = PetController;
