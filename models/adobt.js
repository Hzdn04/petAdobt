"use strict";
const { Model } = require("sequelize");
module.exports = (sequelize, DataTypes) => {
  class adobt extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
      adobt.belongsToMany(models.pet, { through: models.petAdobt });
    }
  }
  adobt.init(
    {
      name: DataTypes.STRING,
      address: DataTypes.STRING,
      adobt_date: DataTypes.DATE,
      total_price: DataTypes.INTEGER,
    },
    {
      sequelize,
      modelName: "adobt",
    }
  );
  return adobt;
};
