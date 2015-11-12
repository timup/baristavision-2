class User < ActiveRecord::Base
  has_one :authentication

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # after_create :set_auth

  # def set_auth
  # 	self.create_authentication
  # 	self.save!
  # end


end
