require 'spec_helper'

describe IOSCertEnrollment::Profile do
  before :each do
    IOSCertEnrollment.configure do |cert|
      cert.ssl_certificate = 'a'
      cert.ssl_key = 'b'
      cert.base_url = 'c'
      cert.identifier = 'd'
      cert.organization = 'e'
    end
    @profile = IOSCertEnrollment::Profile.new
  end
  describe "#encryption_cert_request" do
    it "will create a SCEP certificate payload" do
      payload = @profile.send(:encryption_cert_request, "Profile Service")
      expect(payload['PayloadContent']["Subject"][1][0][0]).to eq 'CN'
      expect(payload['PayloadContent']["Subject"][1][0][1]).to include "Profile Service"
      # TODO
    end
  end
  describe "#general_payload" do
    it "will return a general payload" do
      payload = @profile.send(:general_payload)
      expect(payload).to include 'PayloadUUID'
      expect(payload).to include 'PayloadVersion'
      expect(payload['PayloadOrganization']).to eq IOSCertEnrollment.organization
    end
  end
  pending "TODO"
end
