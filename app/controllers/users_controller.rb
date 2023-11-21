class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @books = @user.books # 個人が投稿したものすべてを表示できる
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
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end
