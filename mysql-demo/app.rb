require 'mysql2'
$client = Mysql2::Client.new(:host => "mysql", :username => "root", :password => "root", :database => "mysql")

loop do
  results = $client.query("select * from help_relation;")
  count = 0
  results.each do |row|
    count += 1
  end
  puts "Found #{count} rows"
  sleep Random.rand
end
