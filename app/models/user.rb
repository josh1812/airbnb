class User < ActiveRecord::Base

has_many :posts

  validates :email, :presence => true
  validates :name, :presence => true
  validates :email, :uniqueness => true
  validates :name, :uniqueness => true

  def self.authenticate(passed_in_email, passed_in_password)
    @user = User.find_by(email: passed_in_email)
    if @user && @user.password == passed_in_password
      @user
    else
      nil
    end
  end
end