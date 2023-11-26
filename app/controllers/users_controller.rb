class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Signed in successfully."
      redirect_to books_path
    else
      render 'users/show'
    end
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books # 個人が投稿したものすべてを表示できる
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
    @book = Book.new
    @user = current_user
  end

  def update
    @user = User.find(params[:id]) # ユーザーの取得
    if @user.update(user_params)
      flash[:success] = "You have updated user successfully."
      redirect_to user_path(@user.id) # ユーザーの詳細ページへのパス
    else
      render :edit
    end
  end

  def destroy　# ログアウト処理を実行
    flash[:success] = "Signed out successfully."
    redirect_to root_path
  end


  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end
end
