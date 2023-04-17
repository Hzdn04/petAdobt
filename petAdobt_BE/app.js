const express = require("express");
const app = express();
const port = process.eventNames.PORT || 3001;
const routes = require("./routes");
const cors = require("cors");

app.use(cors());
app.use(express.json());
app.use(
  express.urlencoded({
    extended: true,
  })
);
app.use("/assets", express.static("assets"));

app.use(routes);

app.listen(port, () => {
  console.log(`Listening on port ${port}`);
});
