class RegistrationsController < Devise::RegistrationsController

  respond_to :json

  # Modified the Devise create method to for purpose of building API 
  # Create does not respond with path on successful sign-up, instead this is handled by the front-end. 
  # Also removed flash messages. 
  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        sign_up(resource_name, resource)
        render status: 200
      else
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      render status: 400
    end
  end

  private

  # Override Devise sign up params to include name field
  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # Override Devise account update params to include name field 
  def account_update_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password)
  end

end
