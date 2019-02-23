class UsersController < ApplicationController
	before_action :authenticate_user!
	def show
		@user = User.find(params[:id])
		@book = Book.new
	  	@books =@user.books
	end

	def edit
		@user = User.find(params[:id])

	end

	def update
		@user =User.find(params[:id])
		if @user.update(user_params)
			flash[:success] = "successfully updated."
			redirect_to user_path(@user.id)
		else
			render :edit
		end
	end

	def index
		@users =User.all.order(updated_at: :asc)
		@books =Book.all.order(updated_at: :asc)
		@user = User.find(current_user.id)
		@book = Book.new
		@post =Book.new
	end

	private#ストロングパラメータのメソッドを使用してフォームからデータを受け取る
	 def user_params
	 	params.require(:user).permit(:introduction, :image, :name)
	 end

end
