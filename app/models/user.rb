class User < ApplicationRecord
  has_many :messages, dependent: :nullify
  has_many :rooms, dependent: :nullify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null

  validates :name, presence: true

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name # Assuming the user model has a name
    end
  end

  def generate_jwt
    JWT.encode({ sub: id, exp: 24.hours.from_now.to_i }, Rails.application.credentials.secret_key_base)
  end
end
