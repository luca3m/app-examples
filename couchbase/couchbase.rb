require 'couchbase'

c = Couchbase.connect

loop do
        c.set('foo', 0)
        c.get('foo')
        c.touch('foo')
        c.incr('foo')
        sleep Random.rand
end
