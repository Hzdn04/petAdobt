'use strict';

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up (queryInterface, Sequelize) {
    return queryInterface.bulkInsert('pets', [
      {
      pet_type: 'Cat',
      name: 'John',
      description: 'Kucing disebut juga kucing domestik atau kucing rumah adalah sejenis mamalia karnivora dari keluarga Felidae. Kata "kucing" biasanya merujuk kepada "kucing" yang telah dijinakkan, tetapi bisa juga bisa merujuk kepada "kucing besar" seperti singa dan harimau yang juga termasuk jenis kucing',
      race: 'Persia',
      sex: 'male',
      color: 'black',
      weight: 2,
      age: 2,
      price: 230000,
      stock: 10,
      image: 'https://www.alleycat.org/wp-content/uploads/2019/03/FELV-cat.jpg',
      createdAt: new Date(),
      updatedAt: new Date()
    },
    {
      pet_type: 'Dog',
      name: 'Angela',
      description: 'Anjing domestik atau Anjing adalah hewan mamalia yang telah mengalami domestikasi dari serigala sejak 15.000 tahun yang lalu, bahkan kemungkinan sudah sejak 100.000 tahun yang lalu berdasarkan bukti genetik berupa penemuan fosil dan tes DNA.',
      race: 'Beagle',
      sex: 'female',
      color: 'yellow',
      weight: 5,
      age: 4,
      price: 1300000,
      stock: 10,
      image: 'https://hips.hearstapps.com/hmg-prod/images/dog-puppy-on-garden-royalty-free-image-1586966191.jpg?crop=1.00xw:0.669xh;0,0.190xh&resize=1200:*',
      createdAt: new Date(),
      updatedAt: new Date()
    },

  ]);
  },

  async down (queryInterface, Sequelize) {
    return queryInterface.bulkDelete('pets', null, {});
  }
};
