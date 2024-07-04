const jwt = require('jsonwebtoken')
const bcrypt = require('bcryptjs')

const users = require('../models/user.model')

const register = (req, res) => {
  const { email, password } = req.body

  const hashPass = bcrypt.hashSync(password, 12)
  //  console.log(hashPass)

  const newUser = {
    id: Date.now(),
    email,
    password: hashPass
  }

  users.push(newUser)
  //  console.log(users)

  const token = jwt.sign({ id: newUser.id }, process.env.SECRET_KEY, { expiresIn: '1h' })

  res.status(201).json({ auth: true, token })
}

const login = (req, res) => {
  const { email, password } = req.body

  const user = users.find(u => u.email === email)
  if (!user) {
    res.status(404).json({ error: 'Usuario no existe' })
  }

  const valid = bcrypt.compareSync(password, user.password)
  if (!valid) {
    res.status(401).json({ auth: false, token: null })
  }

  console.log(users)
  const token = jwt.sign({ id: users.id }, process.env.SECRET_KEY, { expiresIn: '1h' })

  res.status(200).json({ auth: true, token })
}

module.exports = {
  register,
  login
}
