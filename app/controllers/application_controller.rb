class ApplicationController < ActionController::API
  include Api::Errors
  def root
    head :ok
  end

  private
end
