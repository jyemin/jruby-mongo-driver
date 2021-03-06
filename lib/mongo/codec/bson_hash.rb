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

java_import org.bson.BsonDocumentWrapper
java_import org.bson.conversions.Bson

module Mongo
  module Codec
    class BsonHash
      include Bson

      def initialize(hash)
        @hash = hash
      end

      def to_bson_document(a_class, codec_registry)
        BsonDocumentWrapper.new(@hash, Mongo::Codec::HashCodec.new)
      end

    end
  end
end