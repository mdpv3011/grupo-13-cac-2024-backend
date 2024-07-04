require('dotenv').config()

const express = require('express')
const app = express()

app.get('/', (req, res) => {
  res.send('Hola Express')
})

app.use(express.json())

app.use('/juegos', require('./routes/games.router'))

app.use('/auth', require('./routes/auth.router'))

const PORT = process.env.PORT || 1235

app.listen(PORT, () => console.log(`http://localhost:${PORT}`))
