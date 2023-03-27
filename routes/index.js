const routes = require("express").Router();
const petRoutes = require("./petRoute.js");
const adobtRoutes = require("./adobtRoute.js");

routes.get("/", (req, res) => {
  res.json({
    message: `test`,
  });
  //   res.render("index.ejs");
});

routes.use("/pets", petRoutes);
routes.use("/adobts", adobtRoutes);

module.exports = routes;
