# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :citext           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  last_name              :string
#  provider               :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer          default("user"), not null
#  uid                    :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]

  enum role: { user: 0, admin: 1, moderator: 2 }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  has_many :boards, dependent: :destroy
  has_one_attached :avatar

            def self.from_google(u)
              create_with(uid: u[:uid], name: u[:name], provider: 'google',
                          password: Devise.friendly_token[0, 20]).find_or_create_by!(email: u[:email])
            end
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.first_name = auth.info.first_name #assuming auth.info has a first_name
      user.last_name = auth.info.last_name

      if auth.info.image.present?
        avatar_url = auth.info.image
        downloaded_avatar = Down.download(avatar_url) # Use the 'down' gem to download the image
        user.avatar.attach(io: downloaded_avatar, filename: "avatar.jpg")
      end
      

      # If you are using confirmable and the provider(s) you use validate emails
      #uncoment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end
end
