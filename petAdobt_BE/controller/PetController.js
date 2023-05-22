const { pet, adobt, petAdobt } = require("../models");

class PetController {
  static async getPets(req, res) {
    try {
      let pets = await pet.findAll({ order: [["race", "ASC"]] });
      let status = true;
      //   const rpConvert = require("rupiah-format");
      res.status(200).json({status, data: pets});
      // res.status(200).json(pets);
      //   res.render("pets/index.ejs", { pets, adobts, rpConvert });
    } catch (err) {
      res.status(500).json(err);
    }
  }

  static async petInfo(req, res) {
    try {
      const id = +req.params.id;
      let petInfo = await pet.findByPk(id);

      petInfo
        ? res.status(200).json(petInfo)
        : res.status(404).json({ message: `Pet not found` });
    } catch (error) {
      req.status(500).json(error);
    }
  }

  static async adobtPage(req, res) {
    try {
      const id = Number(req.params.id);
      const adobts = await adobt.findAll();
      const pets = await pet.findByPk(id);
      adobts.length === 0
        ? res.status(200).json({ message: `` })
        : // res.redirect("../adobts/create")
          res.render("petAdobts/createPage.ejs", { adobts, pets });
      //   res.render("adobts/createPage.ejs");
    } catch (err) {
      res.json(err);
    }
  }

  static async createPage(req, res) {
    res.render("pets/createPage.ejs");
  }

  static async create(req, res) {
    try {
      const { pet_type, race, age, price, stock } = req.body;
      const image =
        req.protocol + `://` + req.get("host") + "/assets/" + req.file.filename;
      console.log(req.file.path);

      //     console.log(req.userData);
      let resPets = await pet.create({
        pet_type,
        race,
        age,
        price,
        stock,
        image,
      });

      res.status(200).json(resPets);
      //   res.redirect("/pets");
    } catch (err) {
      res.status(500).json(err);
    }
  }

  static async delete(req, res) {
    try {
      const id = Number(req.params.id);

      //   let delPetAdobt = await petAdobt.destroy({
      //     where: {
      //       petId: id,
      //     },
      //   });

      let delPet = await pet.destroy({
        where: { id },
      });
      let delPetAdobt = await petAdobt.destroy({
        where: { petId: id },
      });

      delPet === 1
        ? res.status(200).json({
            message: `Pet id ${id} has been deleted!`,
          })
        : //   res.redirect("/pets")
          res.status(400).json({
            message: `Pet id ${id} has not been deleted!`,
          });
    } catch (err) {
      res.status(500).json(err);
    }
  }

  static async updatePage(req, res) {
    try {
      const id = Number(req.params.id);
      const result = await pet.findByPk(id);
      result === null
        ? res.json(`Couldn't this ${id}`)
        : res.status(200).json({ message: `Pet has been updated` });
      // res.render("pets/updatePage.ejs", { pets: result });
    } catch (error) {
      res.status(500).json(error);
    }
  }

  static async update(req, res) {
    try {
      const id = Number(req.params.id);
      const { pet_type, race, age, price, stock } = req.body;

      const image =
        req.protocol + `://` + req.get("host") + "/assets/" + req.file.filename;

      let result = await pet.update(
        {
          pet_type,
          race,
          age,
          price,
          stock,
          image,
        },
        {
          where: { id },
        }
      );

      result[0] === 1
        ? res.status(200).json({
            message: `Id ${id} has been updated`,
          })
        : //   res.redirect("/pets")
          res.status(400).json({
            message: `Id ${id} not updated`,
          });
    } catch (err) {
      res.status(500).json(err);
    }
  }
}

module.exports = PetController;
