class UsersController < Clearance::UsersController
  def create
    @user = User.new(user_params)

    if @user.save
      sign_in @user
      redirect_back_or url_after_create
    else
      render template: "users/new"
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    byebug
    if @user.update(user_params)
      redirect_to '/listings'
    else
      render template: '/users/edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :gender, :phone, :country, :birthdate)
  end
end
