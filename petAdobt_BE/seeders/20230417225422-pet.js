'use strict';

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up (queryInterface, Sequelize) {
    return queryInterface.bulkInsert('pets', [{
      pet_type: 'Cat',
      race: 'Persia',
      age: 2,
      price: 230000,
      stock: 10,
      image: 'https://www.alleycat.org/wp-content/uploads/2019/03/FELV-cat.jpg',
      createdAt: new Date(),
      updatedAt: new Date()
    }]);
  },

  async down (queryInterface, Sequelize) {
    return queryInterface.bulkDelete('pets', null, {});
  }
};
