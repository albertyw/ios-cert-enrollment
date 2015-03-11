require 'spec_helper'

describe IOSCertEnrollment::Configuration do
  describe "#ssl_key" do
    before :each do
      IOSCertEnrollment.ssl_key = nil
      IOSCertEnrollment.ssl_key_path = nil
    end
    it "Can read from a variable" do
      IOSCertEnrollment.ssl_key = 'asdf'
      expect(IOSCertEnrollment.ssl_key).to eq 'asdf'
    end
    it "Can read from a file" do
      allow(File).to receive(:read).and_return('qwer')
      IOSCertEnrollment.ssl_key_path = 'qwer_file'
      expect(IOSCertEnrollment.ssl_key).to eq 'qwer'
    end
    it "Can read from a lambda" do
      IOSCertEnrollment.ssl_key = lambda { SecureRandom.base64 }
      key1 = IOSCertEnrollment.ssl_key
      key2 = IOSCertEnrollment.ssl_key
      expect(key1).to_not eq key2
    end
  end

  describe "#ssl_certificate" do
    before :each do
      IOSCertEnrollment.ssl_certificate = nil
      IOSCertEnrollment.ssl_certificate_path = nil
    end
    it "Can read from a variable" do
      IOSCertEnrollment.ssl_certificate = 'asdf'
      expect(IOSCertEnrollment.ssl_certificate).to eq 'asdf'
    end
    it "Can read from a file" do
      allow(File).to receive(:read).and_return('qwer')
      IOSCertEnrollment.ssl_certificate_path = 'qwer_file'
      expect(IOSCertEnrollment.ssl_certificate).to eq 'qwer'
    end
    it "Can read from a lambda" do
      IOSCertEnrollment.ssl_certificate = lambda { SecureRandom.base64 }
      cert1 = IOSCertEnrollment.ssl_certificate
      cert2 = IOSCertEnrollment.ssl_certificate
      expect(cert1).to_not eq cert2
    end
  end

  describe "#base_url" do
    before :each do
      IOSCertEnrollment.base_url = nil
    end
    it "Can read from a variable" do
      IOSCertEnrollment.base_url = 'asdf'
      expect(IOSCertEnrollment.base_url).to eq 'asdf'
    end
    it "Can read from a lambda" do
      IOSCertEnrollment.base_url = lambda { SecureRandom.base64 }
      cert1 = IOSCertEnrollment.base_url
      cert2 = IOSCertEnrollment.base_url
      expect(cert1).to_not eq cert2
    end
  end

  describe "#configure" do
    it "Can be configured in a block" do
      IOSCertEnrollment.configure do |cert|
        cert.ssl_certificate = 'a'
        cert.ssl_key = 'b'
        cert.base_url = 'c'
      end
      expect(IOSCertEnrollment.ssl_certificate).to eq 'a'
      expect(IOSCertEnrollment.ssl_key).to eq 'b'
      expect(IOSCertEnrollment.base_url).to eq 'c'
    end
  end

  describe "#options" do
    it "Creates a hash of options and their values" do
      IOSCertEnrollment.configure do |cert|
        cert.ssl_certificate = 'a'
        cert.ssl_key = 'b'
        cert.base_url = 'c'
      end
      options = IOSCertEnrollment.options
      expect(options[:ssl_certificate]).to eq 'a'
      expect(options[:ssl_key]).to eq 'b'
      expect(options[:base_url]).to eq 'c'
    end
  end
end
