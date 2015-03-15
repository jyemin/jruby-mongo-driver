require 'mongo/client'


client = Mongo::Client.new
database = client.get_database('test')
collection = database.get_collection('test')
collection.drop

count = collection.count
print count
print "\n"

collection.insert_many( [{ _id: 0, z: 1}, {_id: 1, z: 2}, {_id: 2, z: 3}])

count = collection.count
print count
print "\n"

doc = collection.find_one({_id: 1})
print doc
print "\n"

