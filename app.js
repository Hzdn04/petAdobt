const express = require("express");
const app = express();
const port = process.eventNames.PORT || 3000;
const routes = require("./routes");

app.use(express.json());
app.use(
  express.urlencoded({
    extended: true,
  })
);

app.use(routes);

app.listen(port, () => {
  console.log(`Listening on port ${port}`);
});
