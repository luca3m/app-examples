require 'mongo'
require 'faker'

include Mongo

client = MongoClient.new(ENV['MONGODB'])
db= client["mydb"]
colls = []

100.times do
	coll = db[Faker::Lorem.word]
	colls << coll
	coll.ensure_index({ :name => Mongo::ASCENDING}, { :unique => 1})
end


loop do
  coll = colls.sample
  name = Faker::Name.first_name
  begin
  	coll.insert( { :name => name,
                 :surname => Faker::Name.last_name,
                 :city => Faker::Address.city,
                 :country_code => Faker::Address.country_code
                })
  	coll.insert( { :name => name,
                 :surname => Faker::Name.last_name,
                 :city => Faker::Address.city,
                 :country_code => Faker::Address.country_code
                })
  rescue
  end
  coll.update({ :name => name}, { "$inc" => { :hits => 1 }})
  coll.find({ :name => name }).each do |item|
  	puts item
  end
  coll.aggregate( [
 	                      { "$match" => {}},
 	                      { "$group" => {
 	                                  	"_id" => "$country_code",
 	                                  	"hits" => { "$sum" => "$hits" }
 	                                  	}
 	                     }
 	             ])
  coll.map_reduce("function() { emit(this.country_code, this.hits) }",
                  "function(key,values) { return Array.sum(values) }",  { :out => { :inline => true }, :raw => true});
  if Random.rand < 0.3
  	coll.remove({ :name => name})
  end
  sleep Random.rand
end
