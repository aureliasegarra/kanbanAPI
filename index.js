const dotenv = require('dotenv');
dotenv.config();
const express = require('express');
const router = require('./app/router');
const cors = require('cors');
const multer = require('multer'); // c'est un body parser, parcourir le body de request et permet à l'api de comprendre ce qu'elle reçoit en données dans le formData

const upload = multer();

const PORT = process.env.PORT || 5050;
const app = express();

// j'utilise ces middleware
app.use(cors());
app.use(upload.array()); 

app.use(express.json());
app.use(router);


app.listen(PORT, () => {
  console.log(`Listening on ${PORT} ...`);
});