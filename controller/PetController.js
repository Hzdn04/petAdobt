const { pet, adobt } = require("../models");

class PetController {
  static async getPets(req, res) {
    try {
      let pets = await pet.findAll({
        include: [adobt],
      });

      // res.json(pets);
      res.render('pets/index.ejs', { pets });
    } catch (err) {
      res.json(err);
    }
  }
  static createPage(req, res) {
    res.render('pets/createPage.ejs');
  }
  
  static create(req, res) {
    
  }
  static delete(req, res) {}
  static updatePage(req, res) {}
  static update(req, res) {}
}

module.exports = PetController;
