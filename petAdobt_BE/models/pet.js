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
      pet.belongsToMany(models.user, { through: models.petAdobt });
    }
  }
  pet.init(
    {
      pet_type: {
        type: DataTypes.STRING,
        allowNull: false,
        validate: {
          notNull: {
            msg: `type cannot be null`,
          },
        },
      },
      name: DataTypes.STRING,
      description: DataTypes.TEXT,
      race: DataTypes.STRING,
      sex: DataTypes.STRING,
      color: DataTypes.STRING,
      weight: DataTypes.INTEGER,
      age: DataTypes.INTEGER,
      price: DataTypes.INTEGER,
      stock: DataTypes.INTEGER,
      image: DataTypes.STRING,
    },
    {
      hooks: {
        beforeCreate: (pet, option) => {
          if (pet.pet_type === "Dog") {
            pet.image =
              pet.image ||
              "https://hips.hearstapps.com/hmg-prod/images/dog-puppy-on-garden-royalty-free-image-1586966191.jpg?crop=1.00xw:0.669xh;0,0.190xh&resize=1200:*";
          } else if (pet.pet_type === "Cat") {
            pet.image =
              pet.image ||
              "https://www.alleycat.org/wp-content/uploads/2019/03/FELV-cat.jpg";
          }
        },
      },
      sequelize,
      modelName: "pet",
    }
  );
  return pet;
};
