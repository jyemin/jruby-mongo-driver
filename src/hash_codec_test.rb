require 'mongo/hash_codec'

java_import org.bson.BsonDocument
java_import org.bson.BsonDocumentWriter
java_import org.bson.BsonDocumentReader
java_import org.bson.codecs.EncoderContext
java_import org.bson.codecs.DecoderContext

codec = Mongo::HashCodec.new

doc = BsonDocument.new
hash = {str: 'foo', i: '1', n: nil, d: {a: 1, b: 2}, a: [1, 2, 3], a1: [[1, 2], {a: 1, b: 2}]}
print hash
print "\n"

codec.encode(BsonDocumentWriter.new(doc), hash, EncoderContext.builder.build)
print doc.to_json
print "\n"

hash = codec.decode(BsonDocumentReader.new(doc), DecoderContext.builder.build)
print hash
