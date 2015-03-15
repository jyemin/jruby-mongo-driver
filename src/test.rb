require 'mongo/client'


client = Mongo::Client.new
database = client.get_database('test')
collection = database.get_collection('test')
collection.drop

count = collection.count
puts count

collection.insert_many( [{ _id: 0, z: 1}, {_id: 1, z: 2}, {_id: 2, z: 3}])

count = collection.count
puts count

doc = collection.find_one({_id: 1})
puts doc

collection.find({}).each { |d| puts d.to_s }

collection.update_one({_id: 0}, {"$set" => {"x" => 1} })

collection.find({}).each { |d| puts d.to_s }

collection.update_many({}, {"$set" => {"y" => 1} })

collection.find({}).each { |d| puts d.to_s }

collection.delete_one({_id: 0})

collection.find({}).each { |d| puts d.to_s }

collection.delete_many({})

collection.find({}).each { |d| puts d.to_s }
