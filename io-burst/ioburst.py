import random

while True:
  with open("/dev/null", "w") as f:
    f.write(bytearray(random.getrandbits(8) for _ in xrange(100)))
