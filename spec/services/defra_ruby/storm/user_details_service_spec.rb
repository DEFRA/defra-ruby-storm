# frozen_string_literal: true

require "webmock/rspec"
require "spec_helper"

RSpec.describe DefraRuby::Storm::UserDetailsService do
  describe "#run" do

    before do
      stub_request(:get, "https://www.timeforstorm.com/serviceportalapi/service.svc?singleWsdl")
        .to_return(
          status: 200,
          body: file_fixture("serviceportalapi_service.xml")
        )

      stub_request(:post, "https://www.timeforstorm.com/ServicePortalAPI/Service.svc")
        .to_return(
          status: 200,
          body: file_fixture("get_user_details_response.xml")
        )
    end

    context "when the request is valid" do
      context "when passing agent username as a parameter" do
        it "returns a successful response" do
          response = described_class.run(username: "valid_username")
          expect(response).to be_a(DefraRuby::Storm::GetUserDetailsResponse)
        end

        it "returns the response with user_id set" do
          response = described_class.run(username: "valid_username")
          expect(response.user_id).not_to be_nil
        end
      end
    end

    context "when the request is invalid" do
      context "when invalid username is passed" do
        before do
          stub_request(:post, "https://www.timeforstorm.com/ServicePortalAPI/Service.svc")
            .to_return(
              status: 200,
              body: file_fixture("get_user_details_error_response.xml")
            )
        end

        it "raises an error" do
          expect { described_class.run(username: "invalid_username") }.to raise_error("Failed to get user details for username: invalid_username")
        end
      end
    end
  end

end
