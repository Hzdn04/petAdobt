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
    try {
      const { pet_type, race, age, price } = req.body;
      let resPets = pet.create({ pet_type, race, age, price });

      res.json({ message: `Data has been added` });
    } catch (err) {
      res.json(err);
    }
  }

  static async delete(req, res) {
    try {
      const id = Number(req.params.id);

      let resPet = await pet.destroy({
        where: { id },
      });

      resPet === 1
        ? res.json({
            message: `Pet id ${id} has been deleted!`,
          })
        : res.json({
            message: `Pet id ${id} has not been deleted!`,
          });
    } catch (err) {
      res.json(err);
    }
  }

  static updatePage(req, res) {}

  static async update(req, res) {
    try {
      const id = Number(req.params.id);
      const { pet_type, race, age, price } = req.body;

      let result = await pet.update(
        {
          pet_type,
          race,
          age,
          price,
        },
        {
          where: { id },
        }
      );

      result[0] === 1
        ? res.json({
            message: `Id ${id} has been updated`,
          })
        : res.json({
            message: `Id ${id} not updated`,
          });
    } catch (err) {
      res.json(err);
    }
  }
}

module.exports = PetController;
