'use strict';
const bcrypt = require('bcrypt');

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up (queryInterface, Sequelize) {
    return queryInterface.bulkInsert('users', [{
      username: 'admin',
      email: 'admin@gmail.com',
      password: bcrypt.hashSync('password', 5),
      name: 'admin',
      age: 20,
      address: 'Ml',
      phone: '086654356',
      image: 'https://via.placeholder.com/100',
      role: 1,
      createdAt: new Date(),
      updatedAt: new Date()
    }]);
  },

  async down (queryInterface, Sequelize) {
    return queryInterface.bulkDelete('users', null, {});
  }
};
