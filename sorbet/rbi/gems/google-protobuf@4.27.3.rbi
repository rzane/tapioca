# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `google-protobuf` gem.
# Please instead update this file by running `bin/tapioca gem google-protobuf`.


# We define these before requiring the platform-specific modules.
# That way the module init can grab references to these.
#
# source://google-protobuf//lib/google/protobuf/message_exts.rb#8
module Google; end

# source://google-protobuf//lib/google/protobuf/message_exts.rb#9
module Google::Protobuf
  class << self
    # source://google-protobuf//lib/google/protobuf.rb#38
    def decode(klass, proto, options = T.unsafe(nil)); end

    # source://google-protobuf//lib/google/protobuf.rb#42
    def decode_json(klass, json, options = T.unsafe(nil)); end

    def deep_copy(_arg0); end

    # @raise [FrozenError]
    def discard_unknown(_arg0); end

    # source://google-protobuf//lib/google/protobuf.rb#30
    def encode(msg, options = T.unsafe(nil)); end

    # source://google-protobuf//lib/google/protobuf.rb#34
    def encode_json(msg, options = T.unsafe(nil)); end
  end
end

# source://google-protobuf//lib/google/protobuf/message_exts.rb#29
class Google::Protobuf::AbstractMessage
  include ::Google::Protobuf::MessageExts
  extend ::Google::Protobuf::MessageExts::ClassMethods

  def initialize(*_arg0); end

  def ==(_arg0); end
  def [](_arg0); end
  def []=(_arg0, _arg1); end
  def clone; end
  def dup; end
  def eql?(_arg0); end
  def freeze; end
  def hash; end
  def inspect; end
  def method_missing(*_arg0); end
  def to_h; end
  def to_s; end

  private

  def respond_to_missing?(*_arg0); end

  class << self
    def decode(*_arg0); end
    def decode_json(*_arg0); end
    def descriptor; end
    def encode(*_arg0); end
    def encode_json(*_arg0); end
  end
end

# Message Descriptor - Descriptor for short.
class Google::Protobuf::Descriptor
  include ::Enumerable

  # @return [Descriptor] a new instance of Descriptor
  def initialize(_arg0, _arg1, _arg2); end

  def each; end
  def each_oneof; end
  def file_descriptor; end
  def lookup(_arg0); end
  def lookup_oneof(_arg0); end
  def msgclass; end
  def name; end
  def options; end
end

class Google::Protobuf::DescriptorPool
  # @raise [ArgumentError]
  def add_serialized_file(_arg0); end

  def lookup(_arg0); end

  class << self
    def generated_pool; end
  end
end

class Google::Protobuf::EnumDescriptor
  include ::Enumerable

  # @return [EnumDescriptor] a new instance of EnumDescriptor
  def initialize(_arg0, _arg1, _arg2); end

  def each; end
  def enummodule; end
  def file_descriptor; end
  def is_closed?; end
  def lookup_name(_arg0); end
  def lookup_value(_arg0); end
  def name; end
  def options; end
end

# source://google-protobuf//lib/google/protobuf.rb#16
class Google::Protobuf::Error < ::StandardError; end

class Google::Protobuf::FieldDescriptor
  # @return [FieldDescriptor] a new instance of FieldDescriptor
  def initialize(_arg0, _arg1, _arg2); end

  # @param msg [Google::Protobuf::Message]
  def clear(_arg0); end

  def default; end

  # Tests if this field has been set on the argument message.
  #
  # @param msg [Google::Protobuf::Message]
  # @raise [TypeError] If the field is not defined on this message.
  # @return [Object] Value of the field on this message.
  def get(_arg0); end

  # Tests if this field has been set on the argument message.
  #
  # @param msg [Google::Protobuf::Message]
  # @raise [TypeError] If this field does not exist on the message
  # @raise [ArgumentError] If this field does not track presence
  # @return [Boolean] True iff message has this field set
  def has?(_arg0); end

  # Tests if this field tracks presence.
  #
  # @return [Boolean] True iff this field tracks presence
  def has_presence?; end

  # Tests if this is a repeated field that uses packed encoding.
  #
  # @return [Boolean] True iff this field is packed
  def is_packed?; end

  def json_name; end
  def label; end
  def name; end
  def number; end
  def options; end

  # call-seq:
  #     FieldDescriptor.set(message, value)
  #
  # Sets the value corresponding to this field to the given value on the given
  # message. Raises an exception if message is of the wrong type. Performs the
  # ordinary type-checks for field setting.
  #
  # @param msg [Google::Protobuf::Message]
  # @param value [Object]
  def set(_arg0, _arg1); end

  def submsg_name; end
  def subtype; end
  def type; end
end

class Google::Protobuf::FileDescriptor
  # @return [FileDescriptor] a new instance of FileDescriptor
  def initialize(_arg0, _arg1, _arg2); end

  def name; end
  def options; end
end

# source://google-protobuf//lib/google/protobuf.rb#46
Google::Protobuf::IMPLEMENTATION = T.let(T.unsafe(nil), Symbol)

# source://google-protobuf//lib/google/protobuf/internal/object_cache.rb#10
module Google::Protobuf::Internal; end

class Google::Protobuf::Internal::Arena; end

# source://google-protobuf//lib/google/protobuf/internal/object_cache.rb#42
class Google::Protobuf::Internal::LegacyObjectCache
  # @return [LegacyObjectCache] a new instance of LegacyObjectCache
  #
  # source://google-protobuf//lib/google/protobuf/internal/object_cache.rb#43
  def initialize; end

  # source://google-protobuf//lib/google/protobuf/internal/object_cache.rb#49
  def get(key); end

  # source://google-protobuf//lib/google/protobuf/internal/object_cache.rb#71
  def try_add(key, value); end

  private

  # source://google-protobuf//lib/google/protobuf/internal/object_cache.rb#86
  def purge; end
end

Google::Protobuf::Internal::OBJECT_CACHE = T.let(T.unsafe(nil), Google::Protobuf::Internal::ObjectCache)

# A pointer -> Ruby Object cache that keeps references to Ruby wrapper
# objects.  This allows us to look up any Ruby wrapper object by the address
# of the object it is wrapping. That way we can avoid ever creating two
# different wrapper objects for the same C object, which saves memory and
# preserves object identity.
#
# We use WeakMap for the cache. If sizeof(long) > sizeof(VALUE), we also
# need a secondary Hash to store WeakMap keys, because our pointer keys may
# need to be stored as Bignum instead of Fixnum.  Since WeakMap is weak for
# both keys and values, a Bignum key will cause the WeakMap entry to be
# collected immediately unless there is another reference to the Bignum.
# This happens on 64-bit Windows, on which pointers are 64 bits but longs
# are 32 bits. In this case, we enable the secondary Hash to hold the keys
# and prevent them from being collected.
#
# source://google-protobuf//lib/google/protobuf/internal/object_cache.rb#25
class Google::Protobuf::Internal::ObjectCache
  # @return [ObjectCache] a new instance of ObjectCache
  #
  # source://google-protobuf//lib/google/protobuf/internal/object_cache.rb#26
  def initialize; end

  # source://google-protobuf//lib/google/protobuf/internal/object_cache.rb#31
  def get(key); end

  # source://google-protobuf//lib/google/protobuf/internal/object_cache.rb#35
  def try_add(key, value); end
end

Google::Protobuf::Internal::SIZEOF_LONG = T.let(T.unsafe(nil), Integer)
Google::Protobuf::Internal::SIZEOF_VALUE = T.let(T.unsafe(nil), Integer)

class Google::Protobuf::Map
  include ::Enumerable

  # @return [Map] a new instance of Map
  def initialize(*_arg0); end

  # call-seq:
  #     Map.==(other) => boolean
  #
  # Compares this map to another. Maps are equal if they have identical key sets,
  # and for each key, the values in both maps compare equal. Elements are
  # compared as per normal Ruby semantics, by calling their :== methods (or
  # performing a more efficient comparison for primitive types).
  #
  # Maps with dissimilar key types or value types/typeclasses are never equal,
  # even if value comparison (for example, between integers and floats) would
  # have otherwise indicated that every element has equal value.
  def ==(_arg0); end

  # call-seq:
  #    Map.[](key) => value
  #
  #  Accesses the element at the given key. Throws an exception if the key type is
  #  incorrect. Returns nil when the key is not present in the map.
  def [](_arg0); end

  # call-seq:
  #     Map.[]=(key, value) => value
  #
  # Inserts or overwrites the value at the given key with the given new value.
  # Throws an exception if the key type is incorrect. Returns the new value that
  # was just inserted.
  def []=(_arg0, _arg1); end

  def clear; end

  # call-seq:
  #    Map.dup => new_map
  #
  # Duplicates this map with a shallow copy. References to all non-primitive
  # element objects (e.g., submessages) are shared.
  def clone; end

  # call-seq:
  #    Map.delete(key) => old_value
  #
  # Deletes the value at the given key, if any, returning either the old value or
  # nil if none was present. Throws an exception if the key is of the wrong type.
  def delete(_arg0); end

  # call-seq:
  #    Map.dup => new_map
  #
  # Duplicates this map with a shallow copy. References to all non-primitive
  # element objects (e.g., submessages) are shared.
  def dup; end

  # call-seq:
  #    Map.each(&block)
  #
  # Invokes &block on each |key, value| pair in the map, in unspecified order.
  # Note that Map also includes Enumerable; map thus acts like a normal Ruby
  # sequence.
  def each; end

  def freeze; end

  # @return [Boolean]
  def has_key?(_arg0); end

  def hash; end
  def inspect; end

  # call-seq:
  #     Map.keys => [list_of_keys]
  #
  # Returns the list of keys contained in the map, in unspecified order.
  def keys; end

  def length; end

  # call-seq:
  #    Map.merge(other_map) => map
  #
  # Copies key/value pairs from other_map into a copy of this map. If a key is
  # set in other_map and this map, the value from other_map overwrites the value
  # in the new copy of this map. Returns the new copy of this map with merged
  # contents.
  def merge(_arg0); end

  def size; end

  # call-seq:
  #    Map.to_h => {}
  #
  # Returns a Ruby Hash object containing all the values within the map
  def to_h; end

  # call-seq:
  #     Map.values => [list_of_values]
  #
  # Returns the list of values contained in the map, in unspecified order.
  def values; end
end

# source://google-protobuf//lib/google/protobuf/message_exts.rb#10
module Google::Protobuf::MessageExts
  mixes_in_class_methods ::Google::Protobuf::MessageExts::ClassMethods

  # source://google-protobuf//lib/google/protobuf/message_exts.rb#20
  def to_json(options = T.unsafe(nil)); end

  # source://google-protobuf//lib/google/protobuf/message_exts.rb#24
  def to_proto(options = T.unsafe(nil)); end

  class << self
    # this is only called in jruby; mri loades the ClassMethods differently
    #
    # source://google-protobuf//lib/google/protobuf/message_exts.rb#13
    def included(klass); end
  end
end

# source://google-protobuf//lib/google/protobuf/message_exts.rb#17
module Google::Protobuf::MessageExts::ClassMethods; end

class Google::Protobuf::MethodDescriptor
  # @return [MethodDescriptor] a new instance of MethodDescriptor
  def initialize(_arg0, _arg1, _arg2); end

  def client_streaming; end
  def input_type; end
  def name; end
  def options; end
  def output_type; end
  def server_streaming; end
end

class Google::Protobuf::OneofDescriptor
  include ::Enumerable

  # @return [OneofDescriptor] a new instance of OneofDescriptor
  def initialize(_arg0, _arg1, _arg2); end

  def each; end
  def name; end
  def options; end
end

# source://google-protobuf//lib/google/protobuf.rb#20
Google::Protobuf::PREFER_FFI = T.let(T.unsafe(nil), FalseClass)

# source://google-protobuf//lib/google/protobuf.rb#17
class Google::Protobuf::ParseError < ::Google::Protobuf::Error; end

# source://google-protobuf//lib/google/protobuf/repeated_field.rb#27
class Google::Protobuf::RepeatedField
  include ::Enumerable
  extend ::Forwardable

  # @return [RepeatedField] a new instance of RepeatedField
  def initialize(*_arg0); end

  def +(_arg0); end

  # @raise [FrozenError]
  def <<(_arg0); end

  def ==(_arg0); end
  def [](*_arg0); end

  # @raise [FrozenError]
  def []=(_arg0, _arg1); end

  def at(*_arg0); end

  # @raise [FrozenError]
  def clear; end

  def clone; end

  # source://google-protobuf//lib/google/protobuf/repeated_field.rb#116
  def collect!(*args, &block); end

  # source://google-protobuf//lib/google/protobuf/repeated_field.rb#116
  def compact!(*args, &block); end

  def concat(_arg0); end

  # source://google-protobuf//lib/google/protobuf/repeated_field.rb#104
  def delete(*args, &block); end

  # source://google-protobuf//lib/google/protobuf/repeated_field.rb#104
  def delete_at(*args, &block); end

  # source://google-protobuf//lib/google/protobuf/repeated_field.rb#116
  def delete_if(*args, &block); end

  def dup; end

  # call-seq:
  #     RepeatedField.each(&block)
  #
  # Invokes the block once for each element of the repeated field. RepeatedField
  # also includes Enumerable; combined with this method, the repeated field thus
  # acts like an ordinary Ruby sequence.
  def each; end

  # source://google-protobuf//lib/google/protobuf/repeated_field.rb#116
  def each_index(*args, &block); end

  # @return [Boolean]
  #
  # source://google-protobuf//lib/google/protobuf/repeated_field.rb#92
  def empty?; end

  # source://google-protobuf//lib/google/protobuf/repeated_field.rb#116
  def fill(*args, &block); end

  # source://google-protobuf//lib/google/protobuf/repeated_field.rb#58
  def first(n = T.unsafe(nil)); end

  # source://google-protobuf//lib/google/protobuf/repeated_field.rb#116
  def flatten!(*args, &block); end

  def freeze; end
  def hash; end

  # source://google-protobuf//lib/google/protobuf/repeated_field.rb#116
  def insert(*args, &block); end

  # source://google-protobuf//lib/google/protobuf/repeated_field.rb#116
  def keep_if(*args, &block); end

  # source://google-protobuf//lib/google/protobuf/repeated_field.rb#69
  def last(n = T.unsafe(nil)); end

  def length; end
  def map; end

  # source://google-protobuf//lib/google/protobuf/repeated_field.rb#116
  def map!(*args, &block); end

  # source://google-protobuf//lib/google/protobuf/repeated_field.rb#81
  def pop(n = T.unsafe(nil)); end

  # @raise [FrozenError]
  def push(*_arg0); end

  # source://google-protobuf//lib/google/protobuf/repeated_field.rb#116
  def reject!(*args, &block); end

  # @raise [FrozenError]
  def replace(_arg0); end

  # source://google-protobuf//lib/google/protobuf/repeated_field.rb#116
  def reverse!(*args, &block); end

  # source://google-protobuf//lib/google/protobuf/repeated_field.rb#116
  def rotate!(*args, &block); end

  # source://google-protobuf//lib/google/protobuf/repeated_field.rb#116
  def select!(*args, &block); end

  # source://google-protobuf//lib/google/protobuf/repeated_field.rb#104
  def shift(*args, &block); end

  # source://google-protobuf//lib/google/protobuf/repeated_field.rb#116
  def shuffle!(*args, &block); end

  def size; end

  # array aliases into enumerable
  def slice(*_arg0); end

  # source://google-protobuf//lib/google/protobuf/repeated_field.rb#104
  def slice!(*args, &block); end

  # source://google-protobuf//lib/google/protobuf/repeated_field.rb#116
  def sort!(*args, &block); end

  # source://google-protobuf//lib/google/protobuf/repeated_field.rb#116
  def sort_by!(*args, &block); end

  # call-seq:
  #    RepeatedField.to_ary => array
  #
  # Used when converted implicitly into array, e.g. compared to an Array.
  # Also called as a fallback of Object#to_a
  def to_ary; end

  # source://google-protobuf//lib/google/protobuf/repeated_field.rb#116
  def uniq!(*args, &block); end

  # source://google-protobuf//lib/google/protobuf/repeated_field.rb#104
  def unshift(*args, &block); end

  def values_at; end

  private

  # @raise [FrozenError]
  def pop_one; end

  class << self
    private

    # source://google-protobuf//lib/google/protobuf/repeated_field.rb#103
    def define_array_wrapper_method(method_name); end

    # source://google-protobuf//lib/google/protobuf/repeated_field.rb#115
    def define_array_wrapper_with_result_method(method_name); end
  end
end

# propagates changes made by user of enumerator back to the original repeated field.
# This only applies in cases where the calling function which created the enumerator,
# such as #sort!, modifies itself rather than a new array, such as #sort
#
# source://google-protobuf//lib/google/protobuf/repeated_field.rb#159
class Google::Protobuf::RepeatedField::ProxyingEnumerator < ::Struct
  # source://google-protobuf//lib/google/protobuf/repeated_field.rb#160
  def each(*args, &block); end
end

class Google::Protobuf::ServiceDescriptor
  include ::Enumerable

  # @return [ServiceDescriptor] a new instance of ServiceDescriptor
  def initialize(_arg0, _arg1, _arg2); end

  def each; end
  def file_descriptor; end
  def name; end
  def options; end
end

# source://google-protobuf//lib/google/protobuf.rb#18
class Google::Protobuf::TypeError < ::TypeError; end
