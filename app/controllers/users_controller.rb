class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @books = @user.books # 個人が投稿したものすべてを表示できる
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id]) # URLを参考に特定のidを持ったレコードを取得する
  end

  def index
    @users = User.all
  end

  def update
    @user = User.find(params[:id]) # ユーザーの取得
    if @user.update(user_params) # ユーザーのアップデート
      redirect_to user_path(@user.id) # ユーザーの詳細ページへのパス
    else
      render 'users/show'
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to books_path
    end
  end
end
