# Copyright 2015 MongoDB, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

java_import org.bson.BsonReader
java_import org.bson.BsonWriter
java_import org.bson.BsonType
java_import org.bson.types.ObjectId

module Mongo
  module Codec
    class HashCodec
      include org.bson.codecs.Codec

      def decode(bson_reader, decoder_context)
        hash = {}
        bson_reader.read_start_document

        while bson_reader.readBsonType != BsonType::END_OF_DOCUMENT
          field_name = bson_reader.readName
          value = decode_value(bson_reader, decoder_context)
          hash[field_name] = value
        end

        bson_reader.read_end_document
        hash
      end

      def decode_value(bson_reader, decoder_context)
        case bson_reader.get_current_bson_type
          when BsonType::NULL
            bson_reader.read_null
            nil
          when BsonType::INT32
            bson_reader.read_int32
          when BsonType::STRING
            bson_reader.read_string
          when BsonType::DOCUMENT
            decode(bson_reader, decoder_context)
          when BsonType::ARRAY
            decode_array(bson_reader, decoder_context)
          else
            raise 'Unsupported type'
        end
      end

      def decode_array(bson_reader, decoder_context)
        a = []
        bson_reader.read_start_array

        while bson_reader.readBsonType != BsonType::END_OF_DOCUMENT
          a.push decode_value(bson_reader, decoder_context)
        end

        bson_reader.read_end_array
        a
      end

      def encode(bson_writer, t, encoder_context)
        bson_writer.write_start_document

        t.each do |key, value|
          bson_writer.write_name(key.to_s)
          encode_value(bson_writer, encoder_context, value)
        end
        bson_writer.write_end_document
      end

      def encode_value(bson_writer, encoder_context, value)
        if value.nil?
          bson_writer.write_null
        elsif value.is_a? String
          bson_writer.write_string(value)
        elsif value.is_a? Integer
          bson_writer.write_int32(value)
        elsif value.is_a? Hash
          encode(bson_writer, value, encoder_context)
        elsif value.is_a? Array
          encode_array(bson_writer, encoder_context, value)
        else
          raise 'Unsupported type'
        end
      end

      def encode_array(bson_writer, encoder_context, value)
        bson_writer.write_start_array

        value.each do |element|
          encode_value(bson_writer, encoder_context, element)
        end

        bson_writer.write_end_array
      end

      def get_encoder_class
        java.lang.ClassLoader.get_system_class_loader.load_class('org.jruby.RubyHash')
      end

    end
  end
end

