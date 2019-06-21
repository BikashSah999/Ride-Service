var express = require('express');
var router = express.Router();
var db = require('../db');
var bodyParser = require('body-parser');

router.use(bodyParser.json()); // for parsing application/json
//router.use(bodyParser.urlencoded({extended: true})); // for parsing application/x-www-form-urlencoded

//getting all the riders information
router.get('/', function(req, res, next) {
  var sql = "SELECT * FROM riders";
  db.query(sql, function(err, rows, fields) {
    if (err) {
      res.status(500).send({ error: 'Something failed!' })
    }
    res.json(rows)
  })
});

//getting riders info by their location
router.get('/address/:rideradd', function(req, res, next) {
  const rideradd = req.params.rideradd;
   db.query('SELECT * FROM riders WHERE rideradd=?',rideradd, function(err, rows, fields) {
    if (rows.length!=0){
    if (err) {
      res.status(500).send({ error: 'Something failed!' })
    }
    res.json(rows)
  }
  else{
    res.json({'res':'No Riders Found'});
  }
  })
});

//getting ridersinfo by their number
router.get('/ridernum/:ridernum', function(req, res, next) {
  const ridernum = req.params.ridernum;
   db.query('SELECT * FROM riders WHERE ridernum=?',ridernum, function(err, rows, fields) {
    if(rows.length!=0){
    if (err) {
      res.status(500).send({ error: 'Something failed!' })
    }
    res.json(rows[0])
  }
  else
  {
     res.json({'res':'No Riders Found'});
  }
  })
});

//getting riders info by their gender
router.get('/ridergen/:ridergen', function(req, res, next) {
  const ridergen = req.params.ridergen;
   db.query('SELECT * FROM riders WHERE ridergen=?',ridergen, function(err, rows, fields) {
    if (err) {
      res.status(500).send({ error: 'Something failed!' })
    }
    res.json(rows)
  })
});

//getting riders info by their address and gender
router.get('/rideradd/:rideradd/ridergen/:ridergen', function(req, res, next) {
  const ridergen = req.params.ridergen;
  const rideradd = req.params.rideradd;
   db.query('SELECT * FROM riders WHERE ridergen=? AND rideradd=?',[ridergen,rideradd], function(err, rows, fields) {
    if(rows.length!=0){
    if (err) {
      res.status(500).send({ error: 'Something failed!' })
    }
    res.json(rows)
  }
  else
  {
    res.json({"res":"No riders Found"});
  }
  })
});
module.exports = router;