# Sequelize Script

npx sequelize-cli init

npx sequelize db:create

npx sequelize-cli model:generate --name pet --attributes pet_type:string,race:string,age:integer,price:integer

npx sequelize-cli model:generate --name adobt --attributes name:string,address:string,email:string,phone:string

npx sequelize-cli model:generate --name petAdobt --attributes petId:integer,adobtId:integer

npx sequelize-cli model:generate --name user --attributes username:string,email:string,password:string,name:string,age:integer,address:string,phone:string,image:string

npx sequelize-cli db:migrate
