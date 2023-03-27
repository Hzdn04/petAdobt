const { adobt, pet } = require("../models");

class AdobtController {
  static async getAdobts(req, res) {
    try {
      let adobts = await adobt.findAll({
        include: [pet],
      });

      // res.json(adobts);
      res.render('adobts/index.ejs', { adobts });
    } catch (err) {
      res.json(err);
    }
  }
  
  static async create(req, res) {
    try {
      const { name, address, adobt_date, total_price } = req.body;
      let resultAdobt = await adobt.create({
          name, address, adobt_date, total_price
      })

      res.json(resultAdobt)
      // res.redirect('/adobts')
  } catch (err) {
      res.json(err)
  }
  }

  static async delete(req, res) {
    try {
      const id = Number(req.params.id);

      let resAdobt = await adobt.destroy({
        where: { id },
      });

      resAdobt === 1
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

  static async update(req, res) {
    try {
      const id = Number(req.params.id);
      const { name, address, adobt_date, total_price } = req.body;

      let result = await adobt.update(
        {
          name, address, adobt_date, total_price
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

  static createPage(req, res) {}
  static updatePage(req, res) {}
}

module.exports = AdobtController;
