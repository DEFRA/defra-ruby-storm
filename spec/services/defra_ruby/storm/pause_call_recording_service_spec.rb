# frozen_string_literal: true

require "webmock/rspec"
require "spec_helper"

RSpec.describe DefraRuby::Storm::PauseCallRecordingService do
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

      stub_request(:post, "https://www.timeforstorm.com/RedCentrexWebservices/Service.svc")
        .to_return(
          status: 200,
          body: file_fixture("pause_call_recording_response.xml")
        )
    end

    context "when the request is valid" do
      context "when passing agent username as a parameter" do
        it "returns a successful response" do
          response = described_class.run(username: "valid_username")
          expect(response).to be_a(DefraRuby::Storm::RecordingResponse)
        end

        it "returns the response with user_id set" do
          response = described_class.run(username: "valid_username")
          expect(response.result).to eq("0")
        end
      end

      context "when passing agent_user_id as a parameter" do
        it "returns a successful response" do
          response = described_class.run(agent_user_id: "valid_agent_user_id")
          expect(response).to be_a(DefraRuby::Storm::RecordingResponse)
        end

        it "returns the response with user_id set" do
          response = described_class.run(agent_user_id: "valid_agent_user_id")
          expect(response.result).to eq("0")
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

      context "when invalid agent_user_id is passed" do
        before do
          stub_request(:post, "https://www.timeforstorm.com/RedCentrexWebservices/Service.svc")
            .to_return(
              status: 200,
              body: file_fixture("pause_call_recording_error_response.xml")
            )
        end

        it "raises an error" do
          expect { described_class.run(agent_user_id: "invalid_agent_user_id") }.to raise_error("Failed to pause call recording for agent_user_id: invalid_agent_user_id")
        end
      end

      context "when no username or agent_user_id is passed" do
        it "raises an error" do
          expect { described_class.run }.to raise_error("You must provide either a username or a agent_user_id")
        end
      end
    end
  end

end
