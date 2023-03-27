const { adobt, pet } = require("../models");

class AdobtController {
  static async getAdobts(req, res) {
    try {
      let adobts = await adobt.findAll({
        include: [pet],
      });

      res.json(adobts);
    } catch (err) {
      res.json(err);
    }
  }
  
  static async create(req, res) {
    try {
      const { name, address, adobt_date, total_price } = req.body;
      let resultAdobt = await company.create({
          name, category
      })
      let resultPet = await pet.create({
          companyId: resultAdobt.id
      })

      // res.json(resultCompany)
      res.redirect('/companies')
  } catch (err) {
      res.json(err)
  }
  }

  static async delete(req, res) {}
  static async update(req, res) {}

  static createPage(req, res) {}
  static updatePage(req, res) {}
}

module.exports = AdobtController;
