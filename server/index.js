const express = require('express');
const env = require('dotenv').config().parsed;
const app = express();
const sql = require('mysql');
const core = require('cors');
const body_parser = require('body-parser');
const path = require('path');

const PORT = env.PORT;


app.use(core());
app.use("/photos", express.static('photos'));
app.use(express.json());

const connection = sql.createConnection({
    host: env.DB_SERVER,
    user: env.DB_USERNAME,
    password: env.DB_PASSWORD,
    database: env.DB_Name,
});

app.get('/', (req, res) => {
    res.send("Access denied!!!");
});
//SELECT `MenuID`,`Price`,`Status`,`Optional`,`EN_Name`,`EN_Descript` FROM `menulist` WHERE 1
app.post('/getmenu', (req, res) => {

    const lang = req.body.lang;
    const Type = req.body.Type;
    var condi = ""
    if (Type === "all"){
        condi = "Type";
    }else if(Type === "food"){
        condi = "3";
    }else if(Type === "drink"){
        condi = "2"
    }else if(Type === "dessert"){
        condi = "1"
    }else{
        condi = "Type";
    }
    var sql_command = ""
    if (lang === "EN") {
        sql_command = "SELECT `MenuID`,`Price`,`Status`,`Type`,`EN_Name` AS `Name`,`EN_Description` AS `Des` FROM `menulist` WHERE Type = "+condi;
    } else if (lang === "KR") {
        sql_command = "SELECT `MenuID`,`Price`,`Status`,`Type`,`KR_Name` AS `Name`,`KR_Description` AS `Des` FROM `menulist` WHERE Type = "+condi;
    } else if (lang === "CN") {
        sql_command = "SELECT `MenuID`,`Price`,`Status`,`Type`,`CN_Name` AS `Name`,`CN_Description` AS `Des` FROM `menulist` WHERE Type = "+condi;
    } else if (lang === "TH") {
        sql_command = "SELECT `MenuID`,`Price`,`Status`,`Type`,`TH_Name` AS `Name`,`TH_Description` AS `Des` FROM `menulist` WHERE Type = "+condi;
    } else {
        sql_command = "SELECT `MenuID`,`Price`,`Status`,`Type`,`EN_Name` AS `Name`,`EN_Description` AS `Des` FROM `menulist` WHERE Type = "+condi;
    }
    try {
        connection.query(sql_command, (err, results) => {
            if (err) {
                res.send(err)
            }
            else {
                console.log(results)
                res.send(results);
            }
        });
    } catch (err) {
        res.send(err.massage);
    }
});
app.post('/getDetail', (req, res) => {
    const lang = req.body.lang;
    const MenuID = req.body.MenuID;
    var sql_command = ""
    if (lang === "EN") {
        sql_command = "SELECT `MenuID`,`Price`,`Status`,`Type`,`EN_Name` AS `Name`,`EN_Description` AS `Des` FROM `menulist` WHERE `MenuID` = " + MenuID;
    } else if (lang === "KR") {
        sql_command = "SELECT `MenuID`,`Price`,`Status`,`Type`,`KR_Name` AS `Name`,`KR_Description` AS `Des` FROM `menulist` WHERE `MenuID` = " + MenuID;
    } else if (lang === "CN") {
        sql_command = "SELECT `MenuID`,`Price`,`Status`,`Type`,`CN_Name` AS `Name`,`CN_Description` AS `Des` FROM `menulist` WHERE `MenuID` = " + MenuID;
    } else if (lang === "TH") {
        sql_command = "SELECT `MenuID`,`Price`,`Status`,`Type`,`TH_Name` AS `Name`,`TH_Description` AS `Des` FROM `menulist` WHERE `MenuID` = " + MenuID;
    } else {
        sql_command = "SELECT `MenuID`,`Price`,`Status`,`Type`,`EN_Name` AS `Name`,`EN_Description` AS `Des` FROM `menulist` WHERE `MenuID` = " + MenuID;
    }
    try {
        connection.query(sql_command, (err, results) => {
            if (err) {
                res.send(err)
            }
            else {
                res.send(results);
            }
        });
    } catch (err) {
        res.send(err.massage);
    }
});

app.post('/getOption', (req, res) => {
    const lang = req.body.lang;
    const MenuID = req.body.MenuID;
    var sql_command = ""
    if (lang === "EN") {
        sql_command = "SELECT `OptionID`,`Description_EN` AS 'Description' , `status` FROM `optionaltable` WHERE `MenuID` = " + MenuID;
    } else if (lang === "KR") {
        sql_command = "SELECT `OptionID`,`Description_KR` AS 'Description' , `status` FROM `optionaltable` WHERE `MenuID` = " + MenuID;
    } else if (lang === "CN") {
        sql_command = "SELECT `OptionID`,`Description_CN` AS 'Description' , `status` FROM `optionaltable` WHERE `MenuID` = " + MenuID;
    } else if (lang === "TH") {
        sql_command = "SELECT `OptionID`,`Description_TH` AS 'Description' , `status` FROM `optionaltable` WHERE `MenuID` = " + MenuID;
    } else {
        sql_command = "SELECT `OptionID`,`Description_EN` AS 'Description' , `status` FROM `optionaltable` WHERE `MenuID` = " + MenuID;
    }
    try {
        // console.log(sql_command);
        connection.query(sql_command, (err, results) => {
            if (err) {
                res.send(err)
            }
            else {
                res.send(results);
            }
        });
    } catch (err) {
        res.send(err.massage);
    }

});
//SELECT menulist.EN_Name AS Name , cart.TableID , cart.OptionID FROM cart INNER JOIN menulist ON cart.MenuID = menulist.MenuID WHERE cart.MenuID = 2 AND cart.status = 1
app.post('/food_bar', (req, res) => {
    const lang = req.body.lang;
    if (lang === "EN") {
        sql_command = `SELECT menulist.EN_Name AS Name , cart.TableID , cart.cartID, cart.OptionID FROM cart INNER JOIN menulist ON cart.MenuID = menulist.MenuID WHERE cart.status = 1 AND menulist.Type = 1`;
    } else if (lang === "KR") {
        sql_command = `SELECT menulist.KR_Name AS Name , cart.TableID , cart.cartID, cart.OptionID FROM cart INNER JOIN menulist ON cart.MenuID = menulist.MenuID WHERE cart.status = 1 AND menulist.Type = 1`;
    } else if (lang === "CN") {
        sql_command = `SELECT menulist.CN_Name AS Name , cart.TableID , cart.cartID, cart.OptionID FROM cart INNER JOIN menulist ON cart.MenuID = menulist.MenuID WHERE cart.status = 1 AND menulist.Type = 1`;
    } else if (lang === "TH") {
        sql_command = `SELECT menulist.TH_Name AS Name , cart.TableID , cart.cartID, cart.OptionID FROM cart INNER JOIN menulist ON cart.MenuID = menulist.MenuID WHERE cart.status = 1 AND menulist.Type = 1`;
    } else {
        sql_command = `SELECT menulist.EN_Name AS Name , cart.TableID , cart.cartID, cart.OptionID FROM cart INNER JOIN menulist ON cart.MenuID = menulist.MenuID WHERE cart.status = 1 AND menulist.Type = 1`;
    }
    try {
        // console.log(sql_command);
        connection.query(sql_command, (err, results) => {
            if (err) {
                res.send(err)
            }
            else {
                res.send(results);
            }
        });
    } catch (err) {
        res.send(err.massage);
    }

});

app.post('/drink_bar', (req, res) => {
    const lang = req.body.lang;
    if (lang === "EN") {
        sql_command = `SELECT menulist.EN_Name AS Name , cart.TableID , cart.OptionID , cart.cartID FROM cart INNER JOIN menulist ON cart.MenuID = menulist.MenuID WHERE cart.status = 1 AND menulist.Type = 2`;
    } else if (lang === "KR") {
        sql_command = `SELECT menulist.KR_Name AS Name , cart.TableID , cart.OptionID , cart.cartID FROM cart INNER JOIN menulist ON cart.MenuID = menulist.MenuID WHERE cart.status = 1 AND menulist.Type = 2`;
    } else if (lang === "CN") {
        sql_command = `SELECT menulist.CN_Name AS Name , cart.TableID , cart.OptionID , cart.cartID FROM cart INNER JOIN menulist ON cart.MenuID = menulist.MenuID WHERE cart.status = 1 AND menulist.Type = 2`;
    } else if (lang === "TH") {
        sql_command = `SELECT menulist.TH_Name AS Name , cart.TableID , cart.OptionID , cart.cartID FROM cart INNER JOIN menulist ON cart.MenuID = menulist.MenuID WHERE cart.status = 1 AND menulist.Type = 2`;
    } else {
        sql_command = `SELECT menulist.EN_Name AS Name , cart.TableID , cart.OptionID , cart.cartID FROM cart INNER JOIN menulist ON cart.MenuID = menulist.MenuID WHERE cart.status = 1 AND menulist.Type = 2`;
    }
    try {
        // console.log(sql_command);
        connection.query(sql_command, (err, results) => {
            if (err) {
                res.send(err)
            }
            else {
                res.send(results);
            }
        });
    } catch (err) {
        res.send(err.massage);
    }

});


app.post('/serve_bar', (req, res) => {
    const lang = req.body.lang;
    if (lang === "EN") {
        sql_command = `SELECT menulist.EN_Name AS Name , cart.TableID , cart.cartID , cart.OptionID FROM cart INNER JOIN menulist ON cart.MenuID = menulist.MenuID WHERE cart.status = 2`;
    } else if (lang === "KR") {
        sql_command = `SELECT menulist.KR_Name AS Name , cart.TableID , cart.cartID , cart.OptionID FROM cart INNER JOIN menulist ON cart.MenuID = menulist.MenuID WHERE cart.status = 2`;
    } else if (lang === "CN") {
        sql_command = `SELECT menulist.CN_Name AS Name , cart.TableID , cart.cartID , cart.OptionID FROM cart INNER JOIN menulist ON cart.MenuID = menulist.MenuID WHERE cart.status = 2`;
    } else if (lang === "TH") {
        sql_command = `SELECT menulist.TH_Name AS Name , cart.TableID , cart.cartID , cart.OptionID FROM cart INNER JOIN menulist ON cart.MenuID = menulist.MenuID WHERE cart.status = 2`;
    } else {
        sql_command = `SELECT menulist.EN_Name AS Name , cart.TableID , cart.cartID , cart.OptionID FROM cart INNER JOIN menulist ON cart.MenuID = menulist.MenuID WHERE cart.status = 2`;
    }
    try {
        // console.log(sql_command);
        connection.query(sql_command, (err, results) => {
            if (err) {
                res.send(err)
            }
            else {
                res.send(results);
            }
        });
    } catch (err) {
        res.send(err.massage);
    }

});

app.post('/addcart', (req, res) => {
    const MenuID = req.body.MenuID;
    const Table = req.body.Table;
    const amount = req.body.Amount;
    const op = req.body.Option;
    var option_select = "";
    var first_append = true;
    op.forEach(op => {
        if (op.status == 1) {
            if (first_append) {
                first_append = false;
                option_select = op.OptionID;
            } else {
                option_select = option_select + "," + op.OptionID;
            }
        }
        // console.log(`OptionID: ${op.OptionID}, Description: ${op.Description}, Status: ${op.status}`);
    });
    var sql = `INSERT INTO cart(TableID,MenuID, OptionID,Amount) VALUES (${Table},${MenuID},"${option_select}",${amount})`;

    try {
        // console.log(sql);
        connection.query(sql, (err, results) => {
            if (err) {
                res.send(err)
            }
            else {
                res.send("ok");
            }
        });
    } catch (err) {
        res.send(err.massage);
    }
    // console.log(option_select);
    // res.send(String(option_select));

});

app.post('/order', (req, res) => {
    const table = req.body.Table;
    var orderID = 0;
    var pass;
    var sql = "INSERT INTO `ordertable`(`OrderTable`) VALUES (" + String(table) + ")";
    try {
        // console.log(sql);
        connection.query(sql, (err, results) => {
            if (err) {
                console.log(err);
            }
            else {
                pass;
            }
        });
    } catch (err) {
        pass;
    }
    orderID = 1;
    var sql = `SELECT OrderID FROM ordertable WHERE OrderTable = ${table} AND Status = 1`;
    try {
        // console.log(sql);
        connection.query(sql, (err, results) => {
            if (err) {
                console.log(err);
            }
            else {
                orderID = results[0].OrderID;
                processOrder(orderID, table);
            }
        });
    } catch (err) {
        pass;
    }

    res.send("ok");
});

app.post('/finishMenu', (req, res) => {
    const menuID = req.body.MenuID;
    const OrderID = req.body.OrderID;
    const cart = req.body.CartID;
    var pass;
    var sql = `UPDATE cart SET status = 2 WHERE CartID = ${cart} `;
    try {
        // console.log(sql);
        connection.query(sql, (err, results) => {
            if (err) {
                console.log(err);
            }
            else {
                res.send(String(OrderID) + " / " + String(menuID));
            }
        });
    } catch (err) {
        pass;
    }
});

app.post('/serve', (req, res) => {
    const cart = req.body.CartID;
    var pass;
    var sql = `UPDATE cart SET status = 3 WHERE CartID = ${cart}`;
    try {
        // console.log(sql);
        connection.query(sql, (err, results) => {
            if (err) {
                console.log(err);
            }
            else {
                res.send("ok");
            }
        });
    } catch (err) {
        pass;
    }
});



app.post('/payment', (req, res) => {
    const table = req.body.Table;
    const currentDate = new Date();
    const year = currentDate.getFullYear();
    const month = ('0' + (currentDate.getMonth() + 1)).slice(-2); // Adding 1 because getMonth() returns 0-based index
    const day = ('0' + currentDate.getDate()).slice(-2);
    var date = String(`${year}-${month}-${day}`);

    // console.log(date);
    var sql = "";


});

app.post('/getoptionbyID', (req, res) => {
    const option = req.body.OptionID;
    const lang = req.body.lang;
    var sql = "SELECT `Description_EN` AS Description FROM `optionaltable` WHERE `OptionID` IN (" + String(option) + ")";
    if (lang === "EN") {
        sql = "SELECT `Description_EN` AS Description FROM `optionaltable` WHERE `OptionID` IN (" + String(option) + ")";
    } else if (lang === "KR") {
        sql = "SELECT `Description_KR` AS Description FROM `optionaltable` WHERE `OptionID` IN (" + String(option) + ")";
    } else if (lang === "CN") {
        sql = "SELECT `Description_CN` AS Description FROM `optionaltable` WHERE `OptionID` IN (" + String(option) + ")";
    } else if (lang === "TH") {
        sql = "SELECT `Description_TH` AS Description FROM `optionaltable` WHERE `OptionID` IN (" + String(option) + ")";
    } else {
        sql = "SELECT `Description_EN` AS Description FROM `optionaltable` WHERE `OptionID` IN (" + String(option) + ")";
    }
    try {
        // console.log(sql);
        connection.query(sql, (err, results) => {
            if (err) {
                res.send([]);
            }
            else {
                res.send(results);
            }
        });
    } catch (err) {
        res.send([]);
    }

})



function processOrder(order, table) {
    var sql = `UPDATE cart SET OrderID = ${order} , status = 1 WHERE OrderID = 1 AND TableID = ${table}`;
    var pass;
    try {
        // console.log(sql);
        connection.query(sql, (err, results) => {
            if (err) {
                console.log(err);
            }
            else {
                pass;
            }
        });
    } catch (err) {
        pass;
    }
}







app.listen(PORT, () => {
    console.log(`Server is run on http://localhost:${PORT}`);
});