require 'mongo/client'

client = Mongo::Client.new
database = client.get_database('test')
collection = database.get_collection('test')
collection.drop

t1 = Time.now

100000.times do
  collection.update_one({_id: 0}, {"$set" => {"x" => 1}})
end

t2 = Time.now

puts t2 - t1