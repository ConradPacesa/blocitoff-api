class SessionsController < Devise::SessionsController

  respond_to :json

  def create
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    yield resource if block_given?
    user = @user
    render status: 200, json: { email: user.email, name: user.name, authentication_token: user.authentication_token }
  end

end
