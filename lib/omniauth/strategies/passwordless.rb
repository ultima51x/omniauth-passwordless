require 'omniauth'

module OmniAuth
  module Strategies
    class Passwordless
      include OmniAuth::Strategy

      def request_phase
        form = OmniAuth::Form.new(:title => "User Info", :url => callback_path)
        form.text_field "Email", "email"
        form.button "Enter"
        form.to_response
      end

      def callback_phase
        return fail!(:invalid_email) unless valid_email
        return fail!(:invalid_credentials) unless authenticate
      end

      def valid_email
        # Just checking for a @ character in the string
        /@/.match(request.params["email"])
      end

      def model
        options[:model] || ::PasswordlessAccount
      end

      def authenticate
        email = request.params["email"]
        object = model.where(:email => email.downcase).first_or_create
        object.valid?
      end
    end
  end
end
