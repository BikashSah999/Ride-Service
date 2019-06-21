var express = require('express');
var router = express.Router();
var db = require('../db');
var bodyParser = require('body-parser');

router.use(bodyParser.json()); // for parsing application/json
//router.use(bodyParser.urlencoded({extended: true})); // for parsing application/x-www-form-urlencoded

//Authentication (Login)
router.get('/login/usernum/:number/userpassword/:password', function(req, res, next) {
  const number = req.params.number;
  const password = req.params.password;
   db.query('SELECT * FROM userinfo WHERE number=? AND password=?',[number, password], function(err, rows, fields) {
    if(rows.length!=0){
     if (err) {
      res.status(500).send({ error: 'Something failed!' })
    }
    data1="Login Successfully";
    res.json(rows[0]);
  }
   else{
  data={"res":"Incorrect"};
  res.json(data);
 }
  });
});

//Createin New User (POST)
router.get('/signup-form', function(req, res, next) {
  res.render('signupform', {title: 'Create Account'});
});
router.post('/signup', function(req, res, next) {
  var firstname = req.body.firstname;
  var lastname = req.body.lastname;
  var address = req.body.address;
  var number = req.body.number;
  var email = req.body.email;
  var password = req.body.password;

  db.query("SELECT number FROM userinfo WHERE number=?",[number], function(err,rows,fields) {
    if(rows.length==0){
    if(password!=''){
    if(err) {
      res.status(500).send({ error: 'Something failed!' })
    }
    db.query("INSERT INTO userinfo(firstname,lastname,address,number,email,password) VALUES (?,?,?,?,?,?)",[firstname,lastname,address,number,email,password], function(err, result) {
    if(err) {
      res.status(500).send({ error: 'Something failed!' })
    }
    res.json({'status': 'Account Create Successfully'});
    })
    }
    else
    {
      res.json({"res":"Enter Password"})
    }
  }  
    else{
       data={"res":"User Already exist"};
       res.json(data);
    }

})
});

//Increasing ride service by 1
router.put('update/ride_service/usernum/:number', function(req, res, next) {
  var number = req.params.number;
  db.query("UPDATE userinfo SET ride_service=(ride_service+1) WHERE number=?",[number],function(err, result) {
    if(err) {
      res.status(500).send({ error: 'Something failed!' })
    }
    res.json({'status': 'success'})
  })
});
 

module.exports = router;