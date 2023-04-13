const { pet, adobt, petAdobt } = require("../models");

class PetController {
  static async getPets(req, res) {
    try {
      let adobts = await adobt.findAll();
      let pets = await pet.findAll({
        include: [adobt],
      });

      const rpConvert = require("rupiah-format");
      //   res.json(pets);
      res.render("pets/index.ejs", { pets, adobts, rpConvert });
    } catch (err) {
      res.json(err);
    }
  }

  static async getPetById(req, res) {
    try {
      const id = Number(req.params.id);
      const result = await pirate.findByPk(id);
      result === null ? res.json(`Couldn't this ${id}`) : res.json(result);
    } catch (error) {
      res.json(error);
    }
  }

  static async adobtPage(req, res) {
    try {
      const id = Number(req.params.id);
      const adobts = await adobt.findAll();
      const pets = await pet.findByPk(id);
      adobts.length === 0
        ? res.redirect("../adobts/create")
        : res.render("petAdobts/createPage.ejs", { adobts, pets });
      //   res.render("adobts/createPage.ejs");
    } catch (err) {
      res.json(err);
    }
  }

  static async createPage(req, res) {
    res.render("pets/createPage.ejs");
  }

  static create(req, res) {
    try {
      const { pet_type, race, age, price, stock } = req.body;

      let resPets = pet.create({ pet_type, race, age, price, stock });

      // res.json({ message: `Data has been added` });
      res.redirect("/pets");
    } catch (err) {
      res.json(err);
    }
  }

  static async delete(req, res) {
    try {
      const id = Number(req.params.id);

      let delTransc = await petAdobt.destroy({
        where: {
          petId: id,
        },
      });

      let delPet = await pet.destroy({
        where: { id },
      });

      delPet === 1
        ? // res.json({
          //     message: `Pet id ${id} has been deleted!`,
          //   })
          res.redirect("/pets")
        : res.json({
            message: `Pet id ${id} has not been deleted!`,
          });
    } catch (err) {
      res.json(err);
    }
  }

  static async updatePage(req, res) {
    try {
      const id = Number(req.params.id);
      const result = await pet.findByPk(id);
      result === null
        ? res.json(`Couldn't this ${id}`)
        : res.render("pets/updatePage.ejs", { pets: result });
    } catch (error) {
      res.json(error);
    }
  }

  static async update(req, res) {
    try {
      const id = Number(req.params.id);
      const { pet_type, race, age, price, stock } = req.body;

      let result = await pet.update(
        {
          pet_type,
          race,
          age,
          price,
          stock,
        },
        {
          where: { id },
        }
      );

      result[0] === 1
        ? // res.json({
          //     message: `Id ${id} has been updated`,
          //   })
          res.redirect("/pets")
        : res.json({
            message: `Id ${id} not updated`,
          });
    } catch (err) {
      res.json(err);
    }
  }
}

module.exports = PetController;
