class User < ActiveRecord::Base
  authenticates_with_sorcery!
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications
  
  before_create do
    self.password = SecureRandom.base64
  end
end
