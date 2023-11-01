# frozen_string_literal: true

module DefraRuby
  module Storm
    class GetUserDetailsResponse < BaseResponse
      attr_accessor :code, :user_id, :user_name, :first_name, :last_name, :home_tel, :work_tel, :work_email, :mobile,
                    :alternative_number, :personal_emai
    end
  end
end
