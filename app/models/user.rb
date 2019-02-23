class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

         has_many :books, dependent: :destroy
         attachment :image

         validates :name, presence: true, length: { minimum: 2, maximum: 20}
         validates :introduction, length: { maximum: 50}





     def email_required?
      false
     end

 	 def email_changed?
      false
     end

end
