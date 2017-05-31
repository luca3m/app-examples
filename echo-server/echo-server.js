const net = require('net');
const server = net.createServer((c) => {
  // 'connection' listener
  console.log('client connected');
  c.on('end', () => {
    console.log('client disconnected');
  });
  //c.write('hello\r\n');
  c.pipe(c);
});

server.listen(7, () => {
  console.log('server bound');
});
