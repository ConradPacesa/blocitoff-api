class WelcomeController < ApplicationController
  def index
    render json: :ok
  end
end
