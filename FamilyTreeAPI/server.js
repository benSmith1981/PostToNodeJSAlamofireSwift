
// Get the packages we need
const express = require('express'),
    mongoose = require('mongoose'),
    bodyParser = require('body-parser'),
    path = require('path'),
    fs = require('fs')

var detailRoutes = require('./detail_routes')

// Create our Express application
var app = express();
var port = process.env.PORT || 3000;
var router = express.Router();

app.use(bodyParser.urlencoded({ extended: true }))
app.use(bodyParser.json());

// connect local or with heroku

mongoose.connect(process.env.MONGODB_URI||  'mongodb://localhost/api/', function (error) {
    if (error) console.error(error);
    else console.log('mongo connected');
});

// Initial dummy route for testing
// http://localhost:3000/api

router.get('/', function(req, res) {
  res.json({ 
      api: 'Rest API Dive Advisor',
      base_url: "secret.localhost:"+ port,
      baseauthor: 'edept',
      description: 'Backend dive sites'
    })
})

// ROUTES
detailRoutes(router)

// Register all our routes with /api
app.use('/api', router);

// route connection
app.listen(port);
