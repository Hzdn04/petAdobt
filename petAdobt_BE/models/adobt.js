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
    //   adobt.belongsToMany(models.pet, { through: models.petAdobt });
    }
  }

  adobt.init(
    {
      name: DataTypes.STRING,
      address: DataTypes.STRING,
      email: DataTypes.STRING,
      phone: DataTypes.STRING,
    },
    {
      sequelize,
      modelName: "adobt",
    }
  );

  adobt.afterCreate((adobt) => {
    sendNotification(adobt);
    // showNotification(`Data ${adobt.name} berhasil masuk`);
  });

  function sendNotification(adobt) {
    // ... kode untuk mengirimkan notifikasi ...
    console.log(`Data ${adobt.name} berhasil masuk database`);
  }

  // function showNotification(message) {
  //   // Memeriksa apakah browser mendukung Notification API
  //   if ("Notification" in window) {
  //     // Memeriksa apakah user telah memberikan izin untuk menampilkan notifikasi
  //     if (Notification.permission === "granted") {
  //       // Menampilkan notifikasi
  //       new Notification("Notifikasi", { body: message });
  //     } else if (Notification.permission !== "denied") {
  //       // Meminta izin untuk menampilkan notifikasi
  //       Notification.requestPermission().then((permission) => {
  //         if (permission === "granted") {
  //           // Menampilkan notifikasi
  //           new Notification("Notifikasi", { body: message });
  //         }
  //       });
  //     }
  //   }
  // }

  return adobt;
};
