require 'pg'
$pg = PGconn.connect(ENV['POSTGRES'], 5432, '', '', ENV['POSTGRES_USER'], ENV['POSTGRES_PASSWORD'])

loop do
  res = conn.exec('SELECT tablename, tableowner from pg_tables')
  sleep Random.rand
end
