class SessionsController < Devise::SessionsController
  skip_before_action :verify_signed_out_user
  respond_to :json

  def new
    super
  end

  # Modified the create method on the devise sessions controller to retrun the user info to the client 
  def create
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    yield resource if block_given?
    user = @user
    render status: 200, json: { id: user.id, email: user.email, name: user.name, authentication_token: user.authentication_token }
  end

  # Modified the Devise sessions contotoller destroy to destroy the users auth token. 
  def destroy
    user = User.find_by(authentication_token: request.headers['X-User-Token'])
    user.authentication_token = nil
    user.save
    sign_out(user)
  end
end
