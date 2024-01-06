const express = require('express');
const mongoose = require('mongoose');

const app = express();

app.set('view engine', 'ejs');
app.use(express.urlencoded({ extended: false }));

// Connect to MongoDB (update the connection string with your database name)
mongoose
  .connect('mongodb://10.0.1.2:27017,10.0.1.3:27017,10.0.1.4:27017/?replicaSet=rs0')
  .then(() => console.log('MongoDB Connected'))
  .catch(err => console.log(err));

const Item = require('./models/item.js');

app.get('/', (req, res) => {
  Item.find()
    .then(items => res.render('index', { items }))
    .catch(err => res.status(404).json({ msg: 'No items found' }));
});

app.post('/item/add', (req, res) => {
  const newItem = new Item({
    name: req.body.name
  });

  newItem.save().then(item => res.redirect('/'));
});

// Change the port number if 3000 is in use
const port = 3000;

app.listen(port, () => console.log('Server running on port ' + port));
