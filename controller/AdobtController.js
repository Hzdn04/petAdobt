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
  static createPage(req, res) {}
  static async create(req, res) {}
  static delete(req, res) {}
  static updatePage(req, res) {}
  static update(req, res) {}
}

module.exports = AdobtController;
