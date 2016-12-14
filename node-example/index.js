var express = require('express')
var app = express()
const prom = require('prom-client')
const prom_gc = require('prometheus-gc-stats')
prom_gc()

app.get('/', function (req, res) {
  res.send('Hello World!')
})

app.get('/metrics', function(req, res) {
  res.end(prom.register.metrics());
});

app.listen(3000, function () {
  console.log('Example app listening on port 3000!')
})
