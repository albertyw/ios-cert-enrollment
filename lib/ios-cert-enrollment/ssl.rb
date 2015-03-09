module IOSCertEnrollment::SSL
  def self.key
    @key ||= OpenSSL::PKey::RSA.new IOSCertEnrollment.ssl_key
  end

  def self.certificate
    @certificate ||= OpenSSL::X509::Certificate.new IOSCertEnrollment.ssl_certificate
  end
end
