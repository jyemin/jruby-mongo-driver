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

require 'mongo/codec/hash_codec'
require 'mongo/database'

java_import com.mongodb.ServerAddress
java_import com.mongodb.MongoClient
java_import com.mongodb.MongoClientOptions
java_import org.bson.codecs.configuration.CodecRegistries

module Mongo
  class Client

    def initialize
      options = MongoClientOptions.builder.codec_registry(
          CodecRegistries.fromRegistries(CodecRegistries.from_codecs([Mongo::Codec::HashCodec.new]),
                                         MongoClient.get_default_codec_registry)).build

      @wrapped = MongoClient.new(ServerAddress.new, options)
    end

    def get_database(name)
      Mongo::Database.new(@wrapped::get_database(name))
    end
  end
end