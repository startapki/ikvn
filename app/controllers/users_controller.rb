class UsersController < ApplicationController
  load_and_authorize_resource

  decorates_assigned :users

  def index
    authorize! :manage, User

    add_breadcrumb I18n.t('user.users'), :users_path

    @users = @users.order(email: :asc)
                   .paginate(page: params[:page], per_page: 10)
  end

  def update
    if @user.update(user_params)
      redirect_to users_path, notice: t('model.updated')
    else
      redirect_to users_path, alert: t('model.not_updated')
    end
  end

  private

  def user_params
    params.require(:user).permit(:id, :role)
  end
end
