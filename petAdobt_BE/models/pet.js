"use strict";
const { Model } = require("sequelize");
module.exports = (sequelize, DataTypes) => {
  class pet extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
      pet.belongsToMany(models.adobt, { through: models.petAdobt });
    }
  }
  pet.init(
    {
      pet_type: DataTypes.STRING,
      race: DataTypes.STRING,
      age: DataTypes.INTEGER,
      price: DataTypes.INTEGER,
      stock: DataTypes.INTEGER,
    },
    {
      sequelize,
      modelName: "pet",
    }
  );
  return pet;
};
