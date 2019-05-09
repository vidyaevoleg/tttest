class UsersController < ApplicationController

  def invite
    result = Users::InviteOperation.call(invite_params)
    if result.success?
      head :ok
    else
      render json: { errors: result['result.errors'] }, status: 422
    end
  end

  def remove
    result = Users::Remove.run(remove_params)
    if result.success?
      head :ok
    else
      render json: { errors: result.errors }, status: 422
    end
  end

  private

  def invite_params
    params.fetch(:user, {}).to_unsafe_hash
  end

  def remove_params
    user = User.find(params[:id])
    params.fetch(:user, {}).to_unsafe_hash.merge(user: user)
  end
end
