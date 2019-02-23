class ApplicationController < ActionController::Base
	#deviseを利用する機能（ユーザ登録、ログイン認証など）が実行される前に、
	#configure_permitted_parametersが実行される。
  before_action :configure_permitted_parameters, if: :devise_controller?



  def after_sign_up_path_for(resource)
    user_path(current_user.id)
  end



  def after_sign_in_path_for(resource)
    user_path(current_user.id)
  end

  def after_sign_out_path_for(resource)
    root_path # ログアウト後に遷移するpathを設定
  end
  protected
  # before_action :authenticate_user!
  	#configure_permitted_parametersでは、
  	#devise_parameter_sanitizer.permitでnameのデータ操作を許可する
  	#アクションメソッドが指定されている。ユーザ登録(sign_up)の際、
  	#ユーザ名(name)のデータ


  def configure_permitted_parameters
   devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:email])
   devise_parameter_sanitizer.permit(:sign_in, keys: [:username])
   devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end
end
