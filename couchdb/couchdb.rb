require 'couchrest'
server = CouchRest.new           # assumes localhost by default!
db = server.database!('testdb')  # create db if it doesn't already exist
loop do
# Save a document, with ID
db.save_doc('_id' => 'doc', 'name' => 'test', 'date' => "test")

# Fetch doc
doc = db.get('doc')
doc.inspect # #<CouchRest::Document _id: "doc", _rev: "1-defa304b36f9b3ef3ed606cc45d02fe2", name: "test", date: "2015-07-13">

# Delete
db.delete_doc(doc)
sleep 0.5
end