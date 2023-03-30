"use strict";
const { Model } = require("sequelize");
module.exports = (sequelize, DataTypes) => {
  class petAdobt extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
      petAdobt.belongsTo(models.pet);
      petAdobt.belongsTo(models.adobt);
    }
  }
  petAdobt.init(
    {
      petId: DataTypes.INTEGER,
      adobtId: DataTypes.INTEGER,
      adobt_date: DataTypes.DATE,
      total_price: DataTypes.INTEGER,
    },
    {
      sequelize,
      modelName: "petAdobt",
    }
  );
  return petAdobt;
};
