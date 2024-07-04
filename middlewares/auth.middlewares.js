const jwt = require('jsonwebtoken')

const users = require('../models/user.model')

module.exports = (req, res, next) => {
  const authHeader = req.headers.authorization

  if (!authHeader) {
    return res
      .status(403)
      .json({ auth: false, message: 'No se proveyo un token' })
  }

  const token = authHeader.split(' ')[1]

  if (!token) {
    return res
      .status(403)
      .json({ auth: false, message: 'Token incorrecto' })
  }

  jwt.verify(token, process.env.SECRET_KEY, (error, decoded) => {
    //  console.log(error, decoded)
    if (error) return res.status(500).send({ auth: false, message: 'Fallo la verificacion del token' })

    const user = users.find(u => u.id === decoded.id)
    if (!user) {
      res.status(404).json({ error: 'Usuario no existe' })
    }

    console.log(decoded)
    req.userId = decoded.id

    next()
  })
}
