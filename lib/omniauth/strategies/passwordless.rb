require 'omniauth'

module OmniAuth
  module Strategies
    class Passwordless
      include OmniAuth::Strategy

      uid do
        passwordless.id
      end

      info do
        {:uid => passwordless.id, :email => passwordless.email}
      end

      def request_phase
        form = OmniAuth::Form.new(:title => "User Info", :url => callback_path)
        form.text_field "Email", "email"
        form.button "Enter"
        form.to_response
      end

      def callback_phase
        return fail!(:invalid_email) unless valid_email
        return fail!(:invalid_credentials) unless authenticate
        super
      end

      def valid_email
        # Just checking for a @ character in the string
        /@/.match(request.params["email"])
      end

      def model
        options[:model] || ::PasswordlessAccount
      end

      def authenticate
        passwordless.valid?
      end

      def passwordless
        email = request.params["email"]
        model.where(:email => email.downcase).first_or_create
      end
    end
  end
end
