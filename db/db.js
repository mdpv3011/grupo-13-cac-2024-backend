const mysql = require('mysql2')

const connection = mysql.createConnection({
  host: 'mysql-grupo13.alwaysdata.net',
  user: 'grupo13_',
  password: 'grupo13js',
  database: 'grupo13_gamesite'
})

connection.connect((error) => {
  if (error) {
    return console.log(error)
  }

  console.log('Connected')
})

module.exports = connection
