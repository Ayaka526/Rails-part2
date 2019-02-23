
class BooksController < ApplicationController
	before_action :authenticate_user!
	def new #空のモデルをビューに渡す
		@book = Book.new
		@post =Book.new
	end

	def create #フォームから送られてきたデータを受け取る
			   #そのデータをモデルを通してDBへ保存
		@book =Book.new(book_params)#ストロングパラメーターを使用
		@books =Book.all.order(updated_at: :asc)
		@book.user_id = current_user.id
		if @book.save #DBに保存する
			flash[:success] = "Successfully created."
			redirect_to book_path(@book.id)
		else
			#flash[:notice] ="Error! Please fill out both of two."
			render :index
		end
		@post =Book.new(book_params)

	end

	def index #投稿一覧ページ
		@book = Book.new
	  	@books =Book.all.order(updated_at: :asc)
		@user = User.find(current_user.id)
		@users =User.all.order(updated_at: :asc)
		@post =Book.new
	end

	def show #詳細ページ
		@post =Book.find(params[:id]) #テンプレートからrenderするから
		@user =@post.user
		@book =Book.new
	end

	def edit
		@book =Book.find(params[:id])
		@post =Book.new
	end

	def update #編集内容を保存して、行進をデータベースで反映
		book =Book.find(params[:id])
		if book.update(book_params)
		   flash[:success] = "successfully updated."
		   redirect_to book_path(book.id)
		end
		@post =Book.new
	end

	def destroy
		book= Book.find(params[:id])#削除リンクを押されたpostのid取得
		book.destroy#postを削除
		redirect_to books_path #indexアクションにリダイレクト
		@post =Book.new
	end

	private#ストロングパラメータのメソッドを使用してフォームからデータを受け取る
	 def book_params
	 	params.require(:book).permit(:title, :opinion)
	 end
end