# frozen_string_literal: true

require "webmock/rspec"
require "spec_helper"

RSpec.describe DefraRuby::Storm::API do
  let(:api_client) { described_class.new(config) }

  describe "#get_user_details" do
    let(:config) { DefraRuby::Storm::Configuration.user_details_service_configuration }

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
      it "returns a successful response" do
        response = api_client.get_user_details("valid_username")
        expect(response).to be_a(DefraRuby::Storm::GetUserDetailsResponse)
      end

      it "returns the response with user_id set" do
        response = api_client.get_user_details("valid_username")
        expect(response.user_id).not_to be_nil
      end
    end

    context "when the request is invalid" do
      before do
        stub_request(:post, "https://www.timeforstorm.com/ServicePortalAPI/Service.svc")
          .to_return(
            status: 200,
            body: file_fixture("get_user_details_error_response.xml")
          )
      end

      it "raises an error" do
        expect { api_client.get_user_details("invalid_username") }.to raise_error("Failed to get user details for username: invalid_username")
      end
    end
  end

  describe "#pause_call_recording" do
    let(:config) { DefraRuby::Storm::Configuration.call_recording_service_configuration }

    before do
      stub_request(:post, "https://www.timeforstorm.com/RedCentrexWebservices/Service.svc")
        .to_return(
          status: 200,
          body: file_fixture("pause_call_recording_response.xml")
        )
    end

    context "when the request is valid" do
      it "returns a successful response" do
        response = api_client.pause_call_recording("valid_agent_user_id")
        expect(response).to be_a(DefraRuby::Storm::RecordingResponse)
      end

      it "returns the response with result code set" do
        response = api_client.pause_call_recording("valid_username")
        expect(response.result).to eq("0")
      end
    end

    context "when the request is invalid" do
      before do
        stub_request(:post, "https://www.timeforstorm.com/RedCentrexWebservices/Service.svc")
          .to_return(
            status: 200,
            body: file_fixture("pause_call_recording_error_response.xml")
          )
      end

      it "raises an error" do
        expect { api_client.pause_call_recording("invalid_agent_user_id") }.to raise_error("Failed to pause call recording for agent_user_id: invalid_agent_user_id")
      end
    end
  end

  describe "#resume_call_recording" do
    let(:config) { DefraRuby::Storm::Configuration.call_recording_service_configuration }

    before do
      stub_request(:post, "https://www.timeforstorm.com/RedCentrexWebservices/Service.svc")
        .to_return(
          status: 200,
          body: file_fixture("resume_call_recording_response.xml")
        )
    end

    context "when the request is valid" do
      it "returns a successful response" do
        response = api_client.resume_call_recording("valid_agent_user_id")
        expect(response).to be_a(DefraRuby::Storm::RecordingResponse)
      end

      it "returns the response with result code set" do
        response = api_client.resume_call_recording("valid_username")
        expect(response.result).to eq("0")
      end
    end

    context "when the request is invalid" do
      before do
        stub_request(:post, "https://www.timeforstorm.com/RedCentrexWebservices/Service.svc")
          .to_return(
            status: 200,
            body: file_fixture("resume_call_recording_error_response.xml")
          )
      end

      it "raises an error" do
        expect { api_client.resume_call_recording("invalid_agent_user_id") }.to raise_error("Failed to resume call recording for agent_user_id: invalid_agent_user_id")
      end
    end
  end
end
