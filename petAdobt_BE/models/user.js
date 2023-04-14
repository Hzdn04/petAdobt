"use strict";
const { Model } = require("sequelize");
const { encrypt } = require("../helpers/bcrypt");
module.exports = (sequelize, DataTypes) => {
  class user extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
      user.belongsToMany(models.pet, { through: models.petAdobt });
    }
  }
  user.init(
    {
      username: {
        type: DataTypes.STRING,
        allowNull: false,
        validate: {
          notNull: {
            message: `Username cannot be null.`,
          },
        },
      },
      email: {
        type: DataTypes.STRING,
        allowNull: false,
        validate: {
          notNull: {
            message: `Email cannot be null.`,
          },
        },
      },
      password: {
        type: DataTypes.STRING,
        allowNull: false,
        validate: {
          notNull: {
            message: `Password cannot be null.`,
          },
        },
      },
      name: DataTypes.STRING,
      age: DataTypes.INTEGER,
      address: DataTypes.TEXT,
      phone: DataTypes.STRING,
      image: DataTypes.STRING,
      role: DataTypes.INTEGER,
    },
    {
      hooks: {
        beforeCreate: (user, option) => {
          user.password = encrypt(user.password);
          user.image = user.image || "https://via.placeholder.com/100";
          user.role = user.role || 2;
        },
      },
      sequelize,
      modelName: "user",
    }
  );
  return user;
};
