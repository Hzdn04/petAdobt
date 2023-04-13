const routes = require("express").Router();
const petRoutes = require("./petRoute.js");
const adobtRoutes = require("./adobtRoute.js");
const petadobtRoutes = require("./petadobtRoute.js");
const userRoutes = require("./userRoute.js");

routes.get("/", (req, res) => {
  // res.json({
  //   message: `test`,
  // });
  res.render("index.ejs");
});

routes.use("/users", userRoutes);
routes.use("/pets", petRoutes);
routes.use("/adobts", adobtRoutes);
routes.use("/petadobts", petadobtRoutes);

module.exports = routes;
