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
  const { nombre, autor, id_categoria } = req.body

  const sql = 'INSERT INTO games (nombre, autor, id_categoria, imagen) VALUES ( ?, ?, ?, ?)'

  db.query(sql, [nombre, autor, id_categoria, filename], (error, result) => {
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
  const { id } = req.params
  const { nombre, id_categoria, autor } = req.body

  // Primero, obtener la imagen actual si existe
  db.query('SELECT imagen FROM games WHERE id = ?', [id], (error, results) => {
    if (error) {
      console.error(error)
      return res.status(500).json({ error: 'Ha habido un error al obtener la imagen actual' })
    }

    if (results.length === 0) {
      return res.status(404).json({ message: 'No existe el juego' })
    }

    const currentImage = results[0].imagen

    let sql = 'UPDATE games SET nombre = ?, id_categoria = ?, autor = ? WHERE id = ?'
    const values = [nombre, id_categoria, autor, id]

    if (req.file) {
      const { filename } = req.file
      sql = 'UPDATE games SET nombre = ?, id_categoria = ?, autor = ?, imagen = ? WHERE id = ?'
      values.splice(values.length - 1, 0, filename)
    }

    db.query(sql, values, (error, result) => {
      if (error) {
        if (req.file) {
          const { filename } = req.file
          const filePath = path.resolve(__dirname, '../uploads', filename)
          if (fs.existsSync(filePath)) {
            fs.unlinkSync(filePath)
          }
        }
        console.error(error)
        return res.status(500).json({ error: 'Ha habido un error al actualizar el juego' })
      }

      if (result.affectedRows === 0) {
        if (req.file) {
          const { filename } = req.file
          const filePath = path.resolve(__dirname, '../uploads', filename)
          if (fs.existsSync(filePath)) {
            fs.unlinkSync(filePath)
          }
        }
        return res.status(404).json({ message: 'No existe el juego' })
      }

      if (req.file && currentImage) {
        const currentImagePath = path.resolve(__dirname, '../uploads', currentImage)
        if (fs.existsSync(currentImagePath)) {
          fs.unlinkSync(currentImagePath)
        }
      }

      const game = { id, nombre, id_categoria, autor }
      if (req.file) {
        game.imagen = req.file.filename
      }

      res.json(game)
    })
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
