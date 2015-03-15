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

require 'mongo/codec/bson_hash'

module Mongo
  class Collection
    include Mongo::Codec::BsonHash

    def initialize(wrapped)
      @wrapped = wrapped
    end

    def count
      @wrapped.count
    end

    def find_one(filter)
      @wrapped.find(BsonHash.new(filter)).first
    end

    def insert_one(document)
      @wrapped.insert_one(document)
    end

    def insert_many(documents)
       @wrapped.insert_many(documents)
    end

    def drop
      @wrapped.drop
    end
  end
end