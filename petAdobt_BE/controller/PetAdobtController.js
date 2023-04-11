const { petAdobt, pet, adobt } = require("../models");

class PetAdobtController {
  static async getPetAdobts(req, res) {
    try {
      let petAdobts = await petAdobt.findAll({
        attributes: ["id", "petId", "adobtId", "adobt_date", "total_price"],
        include: [pet, adobt],
      });

      //   res.json(petAdobts);
      res.render("petAdobts/index.ejs", { petAdobts });
    } catch (err) {
      res.json(err);
    }
  }

  static async getPetAdobtTotals(req, res) {
    try {
      
      let petAdobts = await petAdobt.findAll({
        // attributes: [
        //   "id", "petId", "adobtId", "adobt_date", "total_price"
        //   // [sequelize.fn("SUM", sequelize.col('total_price')), 'total'],
        // ],
        // include: [
        //   pet, adobt
        // ],
        group: 'adobtId',
      });
      //   res.json(petAdobts);
      res.render("petAdobts/detailPage.ejs", { petAdobts });
    } catch (err) {
      res.json(err);
    }
  }

  static async create(req, res) {
    try {
      const { petId, adobtId, phone } = req.body;
      let thisPet = await pet.findByPk(petId);

      let updateStock = await thisPet.decrement("stock");
      let total_price = thisPet.price;
      const adobt_date = new Date();

      let result = await petAdobt.create({
        petId: +petId,
        adobtId: +adobtId,
        adobt_date,
        total_price,
      });

      // res.json(thisPet);
      res.redirect("/petAdobts");
    } catch (err) {
      res.json(err);
    }
  }

  static async delete(req, res) {
    try {
      const id = Number(req.params.id);

      let deleteData = await petAdobt.destroy({
        where: { id },
      });

      deleteData === 1
        ? res.redirect("/petAdobts")
        : res.json({
            message: `Pet id ${id} has not been deleted!`,
          });
    } catch (err) {
      res.json(err);
    }
  }
}

module.exports = PetAdobtController;
