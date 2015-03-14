class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_many :authentications, dependent: :destroy
  has_many :tweets

  accepts_nested_attributes_for :authentications

  before_create do
    self.password = SecureRandom.base64
  end
end
