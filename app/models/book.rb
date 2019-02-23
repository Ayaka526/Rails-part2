class Book < ApplicationRecord
	belongs_to :user


	validates :opinion, length: { maximum: 200}
	validates :opinion, presence: true
    validates :title, presence: true


end
