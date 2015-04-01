require 'mongo'

include Mongo

logger = ::Logger.new($stdout)
logger.level = ::Logger::INFO

Mongo::Logger.logger = logger

client = Mongo::Client.new([ '127.0.0.1:27017' ], :database => 'test', :connect => :direct)

coll = client[:test]

coll.drop

coll.insert_one({:_id => 0})


t1 = Time.now
100000.times do
  coll.find({:_id => 0}).update_one({"$set" => {:x => 1}})
end
t2 = Time.now
puts t2 - t1
