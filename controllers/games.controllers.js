const db = require('../db/db')

const fs = require('fs')
const path = require('path')

const index = (req, res) => {
  const sql = 'SELECT * FROM games'

  db.query(sql, (error, rows) => {
    if (error) {
      return res.status(500).json({ error: 'Ha habido un error' })
    }

    res.json(rows)
  })
}

const show = (req, res) => {
  const { id } = req.params

  const sql = 'SELECT * FROM games WHERE id = ?'

  db.query(sql, [id], (error, rows) => {
    if (error) {
      return res.status(500).json({ error: 'Ha habido un error' })
    }

    if (rows.length === 0) {
      return res.status(404).json({ message: 'No existe el juego' })
    }

    res.json(rows[0])
  })
}

const store = (req, res) => {
  const { filename } = req.file
  const { nombre, genero, autor, id_categoria } = req.body

  const sql = 'INSERT INTO games (nombre, genero, autor, id_categoria, imagen) VALUES ( ?, ?, ?, ?, ?)'

  db.query(sql, [nombre, genero, autor, id_categoria, filename], (error, result) => {
    if (error) {
      fs.unlinkSync(path.resolve(__dirname, '../uploads', filename))
      console.error(error)
      return res.status(500).json({ error: 'Ha habido un error' })
    }

    const game = { ...req.body, id: result.insertId }

    res.json(game)
  })
}

const update = (req, res) => {
  let sql = 'UPDATE games SET nombre = ?, genero = ?, id_categoria = ?, autor = ? WHERE id = ?'

  const { id } = req.params
  const { nombre, genero, id_categoria, autor } = req.body

  const values = [nombre, genero, id_categoria, autor]

  if (req.file) {
    const { filename } = req.file
    sql = 'UPDATE games SET nombre = ?, genero = ?, categoria = ?, autor = ?, imagen = ? WHERE id = ?'
    values.push(filename)
  }

  values.push(id)

  db.query(sql, values, (error, result) => {
    if (error) {
      return res.status(500).json({ error: 'Ha habido un error' })
    }

    if (result.affectedRows === 0) {
      return res.status(404).json({ message: 'No existe el juego' })
    }

    // if (result.affectedRows === 1) {

    //    }

    const game = { ...req.body, ...req.params }

    res.json(game)
  })
}

const destroy = (req, res) => {
  const { id } = req.params

  const sql = 'DELETE FROM games WHERE id = ?'

  db.query(sql, [id], (error, result) => {
    if (error) {
      return res.status(500).json({ error: 'Ha habido un error' })
    }

    if (result.affectedRows === 0) {
      return res.status(404).json({ message: 'No existe el juego' })
    }

    res.json({ message: 'Juego borrrado con exito!' })
  })
}

module.exports = {
  index,
  show,
  store,
  update,
  destroy
}
