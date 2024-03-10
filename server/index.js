const express = require('express');
const env = require('dotenv').config().parsed;
const app = express();
const sql = require('mysql');
const core = require('cors');
const body_parser = require('body-parser');

const PORT = env.PORT;


app.use(core());
app.use(express.json());

const connection = sql.createConnection({
    host : env.DB_SERVER,
    user : env.DB_USERNAME,
    password : env.DB_PASSWORD,
    database : env.DB_Name,
});

app.get('/' , (req,res) =>{
    try{
        connection.query("SELECT * FROM `menulist` WHERE 1" , (err, results) =>{
            if(err){
                res.send("err")
            }
            else{
                res.send(results);
            }

        });
    }catch(err){
        res.send(err);
    }
});
//SELECT `MenuID`,`Price`,`Status`,`Optional`,`EN_Name`,`EN_Descript` FROM `menulist` WHERE 1
app.post('/getmenu',(req,res) =>{
    
    const lang = req.body.lang;

    var sql_command = ""
    if (lang === "EN"){
        sql_command = "SELECT `MenuID`,`Price`,`Status`,`Type`,`EN_Name` AS `Name`,`EN_Description` AS `Des` FROM `menulist` WHERE 1";
    }else if(lang === "KR"){
        sql_command = "SELECT `MenuID`,`Price`,`Status`,`Type`,`KR_Name` AS `Name`,`KR_Description` AS `Des` FROM `menulist` WHERE 1";
    }else if(lang === "CN"){
        sql_command = "SELECT `MenuID`,`Price`,`Status`,`Type`,`CN_Name` AS `Name`,`CN_Description` AS `Des` FROM `menulist` WHERE 1";
    }else if(lang === "TH"){
        sql_command = "SELECT `MenuID`,`Price`,`Status`,`Type`,`TH_Name` AS `Name`,`TH_Description` AS `Des` FROM `menulist` WHERE 1";
    }else{
        sql_command = "SELECT `MenuID`,`Price`,`Status`,`Type`,`EN_Name` AS `Name`,`EN_Description` AS `Des` FROM `menulist` WHERE 1";
    }
    try{
        connection.query(sql_command , (err, results) =>{
            if(err){
                res.send(err)
            }
            else{
                res.send(results);
            }
        });
    }catch(err){
        res.send(err.massage);
    }
});



app.listen(PORT, () =>{
    console.log(`Server is run on http://localhost:${PORT}`);
});