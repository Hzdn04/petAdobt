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

      // res.json(resultAdobt)
      res.redirect('/adobts')
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
        ? 
        res.redirect('/adobts')
        : res.json({
            message: `Adobt id ${id} has not been deleted!`,
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
        ? 
        // res.json({
        //     message: `Id ${id} has been updated`,
        //   })
        res.redirect('/adobts')
        : res.json({
            message: `Id ${id} not updated`,
          });
    } catch (err) {
      res.json(err);
    }
  }

  static createPage(req, res) {
    res.render("adobts/createPage.ejs");
  }

  static async updatePage(req, res) {
    try {
      const id = Number(req.params.id);
      const result = await adobt
        .findByPk(id)
          result === null ? res.json(`Couldn't this ${id}`) : res.render("adobts/updatePage.ejs", { adobts: result });

    } catch (error) {
      res.json(error);
    }
  }
}

module.exports = AdobtController;
