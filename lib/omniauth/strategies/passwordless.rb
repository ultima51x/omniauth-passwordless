require 'omniauth'

module OmniAuth
  module Strategies
    class Passwordless
      include OmniAuth::Strategy

      option :fields, [:email]

      def request_phase
        form = OmniAuth::Form.new(:title => "User Info", :url => callback_path)
        options.fields.each do |field|
          form.text_field field.to_s.capitalize.gsub("_", " "), field.to_s
        end
        form.button "Enter"
        form.to_response
      end

    end
  end
end