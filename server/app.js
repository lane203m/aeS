const mysql = require('mysql');
const express = require('express');
var cors = require('cors')
var app = express();
const bodyparser = require('body-parser');

app.use(bodyparser.json());
app.use(cors())
app.use(function(req, res, next) {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
    next();
  });



var con = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "1234",
  database: "aes_db",
  multipleStatements: true
});

con.connect((err) => {
    if (!err)
        console.log('DB connection succeded.');
    else
        console.log('DB connection failed \n Error : ' + JSON.stringify(err, undefined, 2));
});


app.listen(3000, () => console.log('Express server is runnig at port no : 3000'));


//Get all waste
app.get('/waste', (req, res) => {
    console.log("getting");
    con.query('SELECT * FROM waste_items WHERE isDeleted = 0', (err, rows, fields) => {
        if (!err)
            res.send(rows);
        else
            console.log(err);
    })
});

app.get('/deletedWaste/:dateTime', (req, res) => {
    console.log("getting removed");
    console.log(req.params.dateTime);
    con.query('SELECT * FROM waste_items WHERE isDeleted = 1 AND dateModified >= ?', [req.params.dateTime], (err, rows, fields) => {
        if (!err)
            res.send(rows);
        else
            console.log(err);
    })
});

//Delete a waste
app.delete('/waste/:id', (req, res) => {
    console.log("deleting");
    con.query('UPDATE waste_items Set isDeleted = 1, dateModified = utc_timestamp() WHERE idwaste_items = ?', [req.params.id], (err, rows, fields) => {
        if (!err)
            res.send('Deleted successfully.');
        else
            console.log(err);
    })
});


