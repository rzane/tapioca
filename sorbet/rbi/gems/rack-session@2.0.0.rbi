# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `rack-session` gem.
# Please instead update this file by running `bin/tapioca gem rack-session`.


# source://rack-session//lib/rack/session/constants.rb#7
module Rack; end

# source://rack-session//lib/rack/session/constants.rb#8
module Rack::Session; end

# source://rack-session//lib/rack/session/abstract/id.rb#47
module Rack::Session::Abstract; end

# source://rack-session//lib/rack/session/abstract/id.rb#497
class Rack::Session::Abstract::ID < ::Rack::Session::Abstract::Persisted
  # All thread safety and session destroy procedures should occur here.
  # Should return a new session id or nil if options[:drop]
  #
  # source://rack-session//lib/rack/session/abstract/id.rb#527
  def delete_session(req, sid, options); end

  # All thread safety and session retrieval procedures should occur here.
  # Should return [session_id, session].
  # If nil is provided as the session id, generation of a new valid id
  # should occur within.
  #
  # source://rack-session//lib/rack/session/abstract/id.rb#512
  def find_session(req, sid); end

  # All thread safety and session storage procedures should occur here.
  # Must return the session id if the session was saved successfully, or
  # false if the session could not be saved.
  #
  # source://rack-session//lib/rack/session/abstract/id.rb#520
  def write_session(req, sid, session, options); end

  class << self
    # @private
    #
    # source://rack-session//lib/rack/session/abstract/id.rb#498
    def inherited(klass); end
  end
end

# ID sets up a basic framework for implementing an id based sessioning
# service. Cookies sent to the client for maintaining sessions will only
# contain an id reference. Only #find_session, #write_session and
# #delete_session are required to be overwritten.
#
# All parameters are optional.
# * :key determines the name of the cookie, by default it is
#   'rack.session'
# * :path, :domain, :expire_after, :secure, :httponly, and :same_site set
#   the related cookie options as by Rack::Response#set_cookie
# * :skip will not a set a cookie in the response nor update the session state
# * :defer will not set a cookie in the response but still update the session
#   state if it is used with a backend
# * :renew (implementation dependent) will prompt the generation of a new
#   session id, and migration of data to be referenced at the new id. If
#   :defer is set, it will be overridden and the cookie will be set.
# * :sidbits sets the number of bits in length that a generated session
#   id will be.
#
# These options can be set on a per request basis, at the location of
# <tt>env['rack.session.options']</tt>. Additionally the id of the
# session can be found within the options hash at the key :id. It is
# highly not recommended to change its value.
#
# Is Rack::Utils::Context compatible.
#
# Not included by default; you must require 'rack/session/abstract/id'
# to use.
#
# source://rack-session//lib/rack/session/abstract/id.rb#239
class Rack::Session::Abstract::Persisted
  # @return [Persisted] a new instance of Persisted
  #
  # source://rack-session//lib/rack/session/abstract/id.rb#256
  def initialize(app, options = T.unsafe(nil)); end

  # source://rack-session//lib/rack/session/abstract/id.rb#265
  def call(env); end

  # Acquires the session from the environment and the session id from
  # the session options and passes them to #write_session. If successful
  # and the :defer option is not true, a cookie will be added to the
  # response with the session's id.
  #
  # source://rack-session//lib/rack/session/abstract/id.rb#379
  def commit_session(req, res); end

  # source://rack-session//lib/rack/session/abstract/id.rb#269
  def context(env, app = T.unsafe(nil)); end

  # Returns the value of attribute default_options.
  #
  # source://rack-session//lib/rack/session/abstract/id.rb#254
  def default_options; end

  # Returns the value of attribute key.
  #
  # source://rack-session//lib/rack/session/abstract/id.rb#254
  def key; end

  # Returns the value of attribute same_site.
  #
  # source://rack-session//lib/rack/session/abstract/id.rb#254
  def same_site; end

  # Returns the value of attribute sid_secure.
  #
  # source://rack-session//lib/rack/session/abstract/id.rb#254
  def sid_secure; end

  private

  # Session should be committed if it was loaded, any of specific options like :renew, :drop
  # or :expire_after was given and the security permissions match. Skips if skip is given.
  #
  # @return [Boolean]
  #
  # source://rack-session//lib/rack/session/abstract/id.rb#348
  def commit_session?(req, session, options); end

  # source://rack-session//lib/rack/session/abstract/id.rb#414
  def cookie_value(data); end

  # Returns the current session id from the SessionHash.
  #
  # source://rack-session//lib/rack/session/abstract/id.rb#334
  def current_session_id(req); end

  # All thread safety and session destroy procedures should occur here.
  # Should return a new session id or nil if options[:drop]
  #
  # source://rack-session//lib/rack/session/abstract/id.rb#453
  def delete_session(req, sid, options); end

  # Extract session id from request object.
  #
  # source://rack-session//lib/rack/session/abstract/id.rb#326
  def extract_session_id(request); end

  # All thread safety and session retrieval procedures should occur here.
  # Should return [session_id, session].
  # If nil is provided as the session id, generation of a new valid id
  # should occur within.
  #
  # source://rack-session//lib/rack/session/abstract/id.rb#438
  def find_session(env, sid); end

  # @return [Boolean]
  #
  # source://rack-session//lib/rack/session/abstract/id.rb#365
  def force_options?(options); end

  # @return [Boolean]
  #
  # source://rack-session//lib/rack/session/abstract/id.rb#361
  def forced_session_update?(session, options); end

  # Generate a new session id using Ruby #rand.  The size of the
  # session id is controlled by the :sidbits option.
  # Monkey patch this to use custom methods for session id generation.
  #
  # source://rack-session//lib/rack/session/abstract/id.rb#294
  def generate_sid(secure = T.unsafe(nil)); end

  # source://rack-session//lib/rack/session/abstract/id.rb#284
  def initialize_sid; end

  # Extracts the session id from provided cookies and passes it and the
  # environment to #find_session.
  #
  # source://rack-session//lib/rack/session/abstract/id.rb#318
  def load_session(req); end

  # @return [Boolean]
  #
  # source://rack-session//lib/rack/session/abstract/id.rb#357
  def loaded_session?(session); end

  # source://rack-session//lib/rack/session/abstract/id.rb#280
  def make_request(env); end

  # Sets the lazy session at 'rack.session' and places options and session
  # metadata into 'rack.session.options'.
  #
  # source://rack-session//lib/rack/session/abstract/id.rb#307
  def prepare_session(req); end

  # @return [Boolean]
  #
  # source://rack-session//lib/rack/session/abstract/id.rb#369
  def security_matches?(request, options); end

  # Allow subclasses to prepare_session for different Session classes
  #
  # source://rack-session//lib/rack/session/abstract/id.rb#429
  def session_class; end

  # Check if the session exists or not.
  #
  # @return [Boolean]
  #
  # source://rack-session//lib/rack/session/abstract/id.rb#340
  def session_exists?(req); end

  # Sets the cookie back to the client with session id. We skip the cookie
  # setting if the value didn't change (sid is the same) or expires was given.
  #
  # source://rack-session//lib/rack/session/abstract/id.rb#421
  def set_cookie(request, response, cookie); end

  # All thread safety and session storage procedures should occur here.
  # Must return the session id if the session was saved successfully, or
  # false if the session could not be saved.
  #
  # source://rack-session//lib/rack/session/abstract/id.rb#446
  def write_session(req, sid, session, options); end
end

# source://rack-session//lib/rack/session/abstract/id.rb#240
Rack::Session::Abstract::Persisted::DEFAULT_OPTIONS = T.let(T.unsafe(nil), Hash)

# source://rack-session//lib/rack/session/abstract/id.rb#458
class Rack::Session::Abstract::PersistedSecure < ::Rack::Session::Abstract::Persisted
  # source://rack-session//lib/rack/session/abstract/id.rb#481
  def extract_session_id(*_arg0); end

  # source://rack-session//lib/rack/session/abstract/id.rb#475
  def generate_sid(*_arg0); end

  private

  # source://rack-session//lib/rack/session/abstract/id.rb#492
  def cookie_value(data); end

  # source://rack-session//lib/rack/session/abstract/id.rb#488
  def session_class; end
end

# source://rack-session//lib/rack/session/abstract/id.rb#459
class Rack::Session::Abstract::PersistedSecure::SecureSessionHash < ::Rack::Session::Abstract::SessionHash
  # source://rack-session//lib/rack/session/abstract/id.rb#460
  def [](key); end
end

# SessionHash is responsible to lazily load the session from store.
#
# source://rack-session//lib/rack/session/abstract/id.rb#50
class Rack::Session::Abstract::SessionHash
  include ::Enumerable

  # @return [SessionHash] a new instance of SessionHash
  #
  # source://rack-session//lib/rack/session/abstract/id.rb#68
  def initialize(store, req); end

  # source://rack-session//lib/rack/session/abstract/id.rb#88
  def [](key); end

  # source://rack-session//lib/rack/session/abstract/id.rb#114
  def []=(key, value); end

  # source://rack-session//lib/rack/session/abstract/id.rb#120
  def clear; end

  # source://rack-session//lib/rack/session/abstract/id.rb#146
  def delete(key); end

  # source://rack-session//lib/rack/session/abstract/id.rb#125
  def destroy; end

  # source://rack-session//lib/rack/session/abstract/id.rb#93
  def dig(key, *keys); end

  # source://rack-session//lib/rack/session/abstract/id.rb#83
  def each(&block); end

  # @return [Boolean]
  #
  # source://rack-session//lib/rack/session/abstract/id.rb#169
  def empty?; end

  # @return [Boolean]
  #
  # source://rack-session//lib/rack/session/abstract/id.rb#159
  def exists?; end

  # source://rack-session//lib/rack/session/abstract/id.rb#98
  def fetch(key, default = T.unsafe(nil), &block); end

  # @return [Boolean]
  #
  # source://rack-session//lib/rack/session/abstract/id.rb#107
  def has_key?(key); end

  # source://rack-session//lib/rack/session/abstract/id.rb#74
  def id; end

  # Sets the attribute id
  #
  # @param value the value to set the attribute id to.
  #
  # source://rack-session//lib/rack/session/abstract/id.rb#52
  def id=(_arg0); end

  # @return [Boolean]
  #
  # source://rack-session//lib/rack/session/abstract/id.rb#107
  def include?(key); end

  # source://rack-session//lib/rack/session/abstract/id.rb#151
  def inspect; end

  # @return [Boolean]
  #
  # source://rack-session//lib/rack/session/abstract/id.rb#107
  def key?(key); end

  # source://rack-session//lib/rack/session/abstract/id.rb#174
  def keys; end

  # @return [Boolean]
  #
  # source://rack-session//lib/rack/session/abstract/id.rb#165
  def loaded?; end

  # source://rack-session//lib/rack/session/abstract/id.rb#135
  def merge!(hash); end

  # source://rack-session//lib/rack/session/abstract/id.rb#79
  def options; end

  # source://rack-session//lib/rack/session/abstract/id.rb#141
  def replace(hash); end

  # source://rack-session//lib/rack/session/abstract/id.rb#114
  def store(key, value); end

  # source://rack-session//lib/rack/session/abstract/id.rb#130
  def to_hash; end

  # source://rack-session//lib/rack/session/abstract/id.rb#135
  def update(hash); end

  # source://rack-session//lib/rack/session/abstract/id.rb#179
  def values; end

  private

  # source://rack-session//lib/rack/session/abstract/id.rb#194
  def load!; end

  # source://rack-session//lib/rack/session/abstract/id.rb#186
  def load_for_read!; end

  # source://rack-session//lib/rack/session/abstract/id.rb#190
  def load_for_write!; end

  # source://rack-session//lib/rack/session/abstract/id.rb#200
  def stringify_keys(other); end

  class << self
    # source://rack-session//lib/rack/session/abstract/id.rb#56
    def find(req); end

    # source://rack-session//lib/rack/session/abstract/id.rb#60
    def set(req, session); end

    # source://rack-session//lib/rack/session/abstract/id.rb#64
    def set_options(req, options); end
  end
end

# source://rack-session//lib/rack/session/abstract/id.rb#54
Rack::Session::Abstract::SessionHash::Unspecified = T.let(T.unsafe(nil), Object)

# Rack::Session::Cookie provides simple cookie based session management.
# By default, the session is a Ruby Hash that is serialized and encoded as
# a cookie set to :key (default: rack.session).
#
# This middleware accepts a :secrets option which enables encryption of
# session cookies. This option should be one or more random "secret keys"
# that are each at least 64 bytes in length. Multiple secret keys can be
# supplied in an Array, which is useful when rotating secrets.
#
# Several options are also accepted that are passed to Rack::Session::Encryptor.
# These options include:
# * :serialize_json
#     Use JSON for message serialization instead of Marshal. This can be
#     viewed as a security enhancement.
# * :gzip_over
#     For message data over this many bytes, compress it with the deflate
#     algorithm.
#
# Refer to Rack::Session::Encryptor for more details on these options.
#
# Prior to version TODO, the session hash was stored as base64 encoded
# marshalled data. When a :secret option was supplied, the integrity of the
# encoded data was protected with HMAC-SHA1. This functionality is still
# supported using a set of a legacy options.
#
# Lastly, a :coder option is also accepted. When used, both encryption and
# the legacy HMAC will be skipped. This option could create security issues
# in your application!
#
# Example:
#
#   use Rack::Session::Cookie, {
#     key: 'rack.session',
#     domain: 'foo.com',
#     path: '/',
#     expire_after: 2592000,
#     secrets: 'a randomly generated, raw binary string 64 bytes in size',
#   }
#
# Example using legacy HMAC options:
#
#   Rack::Session:Cookie.new(application, {
#     # The secret used for legacy HMAC cookies, this enables the functionality
#     legacy_hmac_secret: 'legacy secret',
#     # legacy_hmac_coder will default to Rack::Session::Cookie::Base64::Marshal
#     legacy_hmac_coder: Rack::Session::Cookie::Identity.new,
#     # legacy_hmac will default to OpenSSL::Digest::SHA1
#     legacy_hmac: OpenSSL::Digest::SHA256
#   })
#
#
#   Rack::Session::Cookie.new(application, {
#     :coder => Rack::Session::Cookie::Identity.new
#   })
#
#
#   Rack::Session::Cookie.new(application, {
#     :coder => Class.new {
#       def encode(str); str.reverse; end
#       def decode(str); str.reverse; end
#     }.new
#   })
#
# source://rack-session//lib/rack/session/cookie.rb#91
class Rack::Session::Cookie < ::Rack::Session::Abstract::PersistedSecure
  # @return [Cookie] a new instance of Cookie
  #
  # source://rack-session//lib/rack/session/cookie.rb#159
  def initialize(app, options = T.unsafe(nil)); end

  # Returns the value of attribute coder.
  #
  # source://rack-session//lib/rack/session/cookie.rb#157
  def coder; end

  # Returns the value of attribute encryptors.
  #
  # source://rack-session//lib/rack/session/cookie.rb#157
  def encryptors; end

  private

  # source://rack-session//lib/rack/session/cookie.rb#277
  def delete_session(req, session_id, options); end

  # source://rack-session//lib/rack/session/cookie.rb#292
  def encode_session_data(session); end

  # source://rack-session//lib/rack/session/cookie.rb#209
  def extract_session_id(request); end

  # source://rack-session//lib/rack/session/cookie.rb#203
  def find_session(req, sid); end

  # @return [Boolean]
  #
  # source://rack-session//lib/rack/session/cookie.rb#282
  def legacy_digest_match?(data, digest); end

  # source://rack-session//lib/rack/session/cookie.rb#288
  def legacy_generate_hmac(data); end

  # source://rack-session//lib/rack/session/cookie.rb#250
  def persistent_session_id!(data, sid = T.unsafe(nil)); end

  # Were consider "secure" if:
  # * Encrypted cookies are enabled and one or more encryptor is
  #   initialized
  # * The legacy HMAC option is enabled
  # * Customer :coder is used, with :let_coder_handle_secure_encoding
  #   set to true
  #
  # @return [Boolean]
  #
  # source://rack-session//lib/rack/session/cookie.rb#306
  def secure?(options); end

  # source://rack-session//lib/rack/session/cookie.rb#213
  def unpacked_cookie_data(request); end

  # source://rack-session//lib/rack/session/cookie.rb#265
  def write_session(req, session_id, session, options); end
end

# Encode session cookies as Base64
#
# source://rack-session//lib/rack/session/cookie.rb#93
class Rack::Session::Cookie::Base64
  # source://rack-session//lib/rack/session/cookie.rb#98
  def decode(str); end

  # source://rack-session//lib/rack/session/cookie.rb#94
  def encode(str); end
end

# N.B. Unlike other encoding methods, the contained objects must be a
# valid JSON composite type, either a Hash or an Array.
#
# source://rack-session//lib/rack/session/cookie.rb#116
class Rack::Session::Cookie::Base64::JSON < ::Rack::Session::Cookie::Base64
  # source://rack-session//lib/rack/session/cookie.rb#121
  def decode(str); end

  # source://rack-session//lib/rack/session/cookie.rb#117
  def encode(obj); end
end

# Encode session cookies as Marshaled Base64 data
#
# source://rack-session//lib/rack/session/cookie.rb#103
class Rack::Session::Cookie::Base64::Marshal < ::Rack::Session::Cookie::Base64
  # source://rack-session//lib/rack/session/cookie.rb#108
  def decode(str); end

  # source://rack-session//lib/rack/session/cookie.rb#104
  def encode(str); end
end

# source://rack-session//lib/rack/session/cookie.rb#127
class Rack::Session::Cookie::Base64::ZipJSON < ::Rack::Session::Cookie::Base64
  # source://rack-session//lib/rack/session/cookie.rb#132
  def decode(str); end

  # source://rack-session//lib/rack/session/cookie.rb#128
  def encode(obj); end
end

# Use no encoding for session cookies
#
# source://rack-session//lib/rack/session/cookie.rb#142
class Rack::Session::Cookie::Identity
  # source://rack-session//lib/rack/session/cookie.rb#144
  def decode(str); end

  # source://rack-session//lib/rack/session/cookie.rb#143
  def encode(str); end
end

# source://rack-session//lib/rack/session/cookie.rb#147
class Rack::Session::Cookie::Marshal
  # source://rack-session//lib/rack/session/cookie.rb#152
  def decode(str); end

  # source://rack-session//lib/rack/session/cookie.rb#148
  def encode(str); end
end

# source://rack-session//lib/rack/session/cookie.rb#256
class Rack::Session::Cookie::SessionId
  # @return [SessionId] a new instance of SessionId
  #
  # source://rack-session//lib/rack/session/cookie.rb#259
  def initialize(session_id, cookie_value); end

  # Returns the value of attribute cookie_value.
  #
  # source://rack-session//lib/rack/session/cookie.rb#257
  def cookie_value; end
end

# source://rack-session//lib/rack/session/encryptor.rb#16
class Rack::Session::Encryptor
  # The secret String must be at least 64 bytes in size. The first 32 bytes
  # will be used for the encryption cipher key. The remainder will be used
  # for an HMAC key.
  #
  # Options may include:
  # * :serialize_json
  #     Use JSON for message serialization instead of Marshal. This can be
  #     viewed as a security enhancement.
  # * :pad_size
  #     Pad encrypted message data, to a multiple of this many bytes
  #     (default: 32). This can be between 2-4096 bytes, or +nil+ to disable
  #     padding.
  # * :purpose
  #     Limit messages to a specific purpose. This can be viewed as a
  #     security enhancement to prevent message reuse from different contexts
  #     if keys are reused.
  #
  # Cryptography and Output Format:
  #
  #   urlsafe_encode64(version + random_data + IV + encrypted data + HMAC)
  #
  #  Where:
  #  * version - 1 byte and is currently always 0x01
  #  * random_data - 32 bytes used for generating the per-message secret
  #  * IV - 16 bytes random initialization vector
  #  * HMAC - 32 bytes HMAC-SHA-256 of all preceding data, plus the purpose
  #    value
  #
  # @raise [ArgumentError]
  # @return [Encryptor] a new instance of Encryptor
  #
  # source://rack-session//lib/rack/session/encryptor.rb#53
  def initialize(secret, opts = T.unsafe(nil)); end

  # source://rack-session//lib/rack/session/encryptor.rb#77
  def decrypt(base64_data); end

  # source://rack-session//lib/rack/session/encryptor.rb#102
  def encrypt(message); end

  private

  # source://rack-session//lib/rack/session/encryptor.rb#139
  def cipher_secret_from_message_secret(message_secret); end

  # source://rack-session//lib/rack/session/encryptor.rb#151
  def compute_signature(data); end

  # Return the deserialized message. The first 2 bytes will be read as the
  # amount of padding.
  #
  # source://rack-session//lib/rack/session/encryptor.rb#182
  def deserialized_message(data); end

  # source://rack-session//lib/rack/session/encryptor.rb#129
  def new_cipher; end

  # source://rack-session//lib/rack/session/encryptor.rb#133
  def new_message_and_cipher_secret; end

  # Returns a serialized payload of the message. If a :pad_size is supplied,
  # the message will be padded. The first 2 bytes of the returned string will
  # indicating the amount of padding.
  #
  # source://rack-session//lib/rack/session/encryptor.rb#169
  def serialize_payload(message); end

  # source://rack-session//lib/rack/session/encryptor.rb#147
  def serializer; end

  # source://rack-session//lib/rack/session/encryptor.rb#143
  def set_cipher_key(cipher, key); end

  # @raise [InvalidMessage]
  #
  # source://rack-session//lib/rack/session/encryptor.rb#158
  def verify_authenticity!(data, signature); end
end

# source://rack-session//lib/rack/session/encryptor.rb#17
class Rack::Session::Encryptor::Error < ::StandardError; end

# source://rack-session//lib/rack/session/encryptor.rb#23
class Rack::Session::Encryptor::InvalidMessage < ::Rack::Session::Encryptor::Error; end

# source://rack-session//lib/rack/session/encryptor.rb#20
class Rack::Session::Encryptor::InvalidSignature < ::Rack::Session::Encryptor::Error; end

# source://rack-session//lib/rack/session/constants.rb#9
Rack::Session::RACK_SESSION = T.let(T.unsafe(nil), String)

# source://rack-session//lib/rack/session/constants.rb#10
Rack::Session::RACK_SESSION_OPTIONS = T.let(T.unsafe(nil), String)

# source://rack-session//lib/rack/session/constants.rb#11
Rack::Session::RACK_SESSION_UNPACKED_COOKIE_DATA = T.let(T.unsafe(nil), String)

# source://rack-session//lib/rack/session/abstract/id.rb#21
class Rack::Session::SessionId
  # @return [SessionId] a new instance of SessionId
  #
  # source://rack-session//lib/rack/session/abstract/id.rb#26
  def initialize(public_id); end

  # Returns the value of attribute public_id.
  #
  # source://rack-session//lib/rack/session/abstract/id.rb#24
  def cookie_value; end

  # @return [Boolean]
  #
  # source://rack-session//lib/rack/session/abstract/id.rb#37
  def empty?; end

  # source://rack-session//lib/rack/session/abstract/id.rb#38
  def inspect; end

  # source://rack-session//lib/rack/session/abstract/id.rb#30
  def private_id; end

  # Returns the value of attribute public_id.
  #
  # source://rack-session//lib/rack/session/abstract/id.rb#24
  def public_id; end

  # Returns the value of attribute public_id.
  #
  # source://rack-session//lib/rack/session/abstract/id.rb#24
  def to_s; end

  private

  # source://rack-session//lib/rack/session/abstract/id.rb#42
  def hash_sid(sid); end
end

# source://rack-session//lib/rack/session/abstract/id.rb#22
Rack::Session::SessionId::ID_VERSION = T.let(T.unsafe(nil), Integer)
