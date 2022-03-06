class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:bio, :username, :name, :street_address, :suburb, :postcode, :state, :phone_number, :tradie])
        devise_parameter_sanitizer.permit(:account_update, keys: [:bio, :username, :name, :street_address, :suburb, :postcode, :state, :phone_number, :tradie])
    end
end
