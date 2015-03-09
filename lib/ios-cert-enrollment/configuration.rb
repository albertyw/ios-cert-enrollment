require File.expand_path('../version', __FILE__)

# Defines constants and methods related to configuration
module IOSCertEnrollment::Configuration
  VALID_OPTIONS_KEYS = [
    :ssl_certificate,
    :ssl_key,
    :ssl_certificate_path,
    :ssl_key_path,
    :base_url,
    :identifier,
    :display_name,
    :organization
  ]

  VALID_OPTIONS_KEYS.freeze

  attr_accessor *VALID_OPTIONS_KEYS

  def ssl_key
    @ssl_key ||= File.read ssl_key_path
  end

  def ssl_certificate
    @ssl_certificate ||= File.read ssl_certificate_path
  end

  # Convenience method to allow configuration options to be set in a block
  def configure
    yield self
  end

  # Create a hash of options and their values
  def options
    VALID_OPTIONS_KEYS.inject({}) do |option, key|
      option.merge!(key => send(key))
    end
  end
end
