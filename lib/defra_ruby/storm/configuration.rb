# frozen_string_literal: true

module DefraRuby
  module Storm
    class Configuration
      attr_accessor :storm_api_username, :storm_api_password,
                    :wsdl, :wsse_auth, :soap_version, :pretty_print_xml, :use_wsa_headers, :env_namespace,
                    :namespace_identifier, :namespaces, :log

      def self.user_details_service_configuration
        {
          wsdl: "https://www.timeforstorm.com/serviceportalapi/service.svc?singleWsdl",
          wsse_auth: [DefraRuby::Storm.configuration.storm_api_username,
                      DefraRuby::Storm.configuration.storm_api_password],
          soap_version: 2,
          pretty_print_xml: true,
          use_wsa_headers: true,
          env_namespace: :soap,
          namespace_identifier: :ngw,
          namespaces: {
            "xmlns:soap" => "http://www.w3.org/2003/05/soap-envelope",
            "xmlns:ngw" => "http://redwoodtech.com/ws/NGware/NGwareTypes"
          },
          log: false
        }
      end

      def self.call_recording_service_configuration
        {
          endpoint: "https://www.timeforstorm.com/RedCentrexWebservices/Service.svc", namespace: "http://redcentrex.redwoodtech.com/calls",
          wsse_auth: [DefraRuby::Storm.configuration.storm_api_username,
                      DefraRuby::Storm.configuration.storm_api_password],
          soap_version: 2,
          pretty_print_xml: true,
          use_wsa_headers: true,
          env_namespace: :soap,
          namespace_identifier: :cal,
          namespaces: {
            "xmlns:soap" => "http://www.w3.org/2003/05/soap-envelope",
            "xmlns:cal" => "http://redcentrex.redwoodtech.com/calls"
          },
          log: false
        }
      end
    end
  end
end
