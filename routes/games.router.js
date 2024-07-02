const express = require('express')
const router = express.Router()

const path = require('path')

const multer = require('multer')

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, 'uploads')
  },
  filename: (req, file, cb) => {
    cb(null, Date.now() + path.extname(file.originalname))
  }
})

const upload = multer({
  storage,
  fileFilter: (req, file, cb) => {
    const fileType = /jpg|png|jpeg/

    const mimeType = fileType.test(file.mimetype)

    const extname = fileType.test(path.extname(file.originalname).toLowerCase())

    if (mimeType && extname) {
      return cb(null, true)
    }

    cb('error: No es un archivo permitido')
  },
  limits: { fileSize: 1080 * 1080 * 1 }
})

const controller = require('../controllers/games.controllers')

// prefijo de juegos

router.get('/', controller.index)
router.get('/:id', controller.show)
router.post('/', upload.single('imagen'), controller.store)
router.put('/:id', upload.single('imagen'), controller.update)
router.delete('/:id', controller.destroy)
