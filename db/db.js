const mysql = require('mysql2')

const connection = mysql.createConnection({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_DATABASE,
  port: 3306
})

connection.connect((error) => {
  if (error) {
    return console.log(error)
  }

  console.log('Connected')
})

module.exports = connection
