class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # configure_permitted_parameters: method runs before each Devise controller action.
  before_action :configure_permitted_parameters, if: :devise_controller?

  # protected methods in class
  protected

  # override configure_permitted_parameters method to allow additional parameters
  # by default devise only allows email, password and password_confirmation
  def configure_permitted_parameters
    # parameters allowed during sign up
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :first_name, :last_name, :major, :expected_graduation_date, :profile_picture ])
    # parameters that can be updated
    devise_parameter_sanitizer.permit(:account_update, keys: [ :first_name, :last_name, :major, :expected_graduation_date,  :profile_picture ])
  end

  # override after_sign_in_path_for method that is called by Devise
  def after_sign_in_path_for(resource)
    # Redirect to the student's profile using devise method current_student
    student_path(current_student) # Redirect to the logged-in student's profile
  end
end
