var express = require('express');
var router = express.Router();
var db = require('../db');
var bodyParser = require('body-parser');

router.use(bodyParser.json()); // for parsing application/json
//router.use(bodyParser.urlencoded({extended: true})); // for parsing application/x-www-form-urlencoded

/* get method for fetch all products. */
router.get('/', function(req, res, next) {
  var sql = "SELECT * FROM riders";
  db.query(sql, function(err, rows, fields) {
    if (err) {
      res.status(500).send({ error: 'Something failed!' })
    }
    res.json(rows)
  })
});
router.get('/address/:rideradd', function(req, res, next) {
  const rideradd = req.params.rideradd;
   db.query('SELECT * FROM riders WHERE rideradd=?',rideradd, function(err, rows, fields) {
    if (err) {
      res.status(500).send({ error: 'Something failed!' })
    }
    res.json(rows)
  })
});
router.get('/ridernum/:ridernum', function(req, res, next) {
  const ridernum = req.params.ridernum;
   db.query('SELECT * FROM riders WHERE ridernum=?',ridernum, function(err, rows, fields) {
    if (err) {
      res.status(500).send({ error: 'Something failed!' })
    }
    res.json(rows)
  })
});
router.get('/ridergen/:ridergen', function(req, res, next) {
  const ridergen = req.params.ridergen;
   db.query('SELECT * FROM riders WHERE ridergen=?',ridergen, function(err, rows, fields) {
    if (err) {
      res.status(500).send({ error: 'Something failed!' })
    }
    res.json(rows)
  })
});

module.exports = router;