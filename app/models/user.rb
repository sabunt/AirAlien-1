class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable
  has_many :rooms, dependent: :destroy
  has_many :reservations, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :feedbacks, dependent: :destroy

  validates :fullname, presence: true, length: { maximum: 50 }


  def self.from_omniauth(auth)
  	user = User.where(email: auth.info.email).first
  	if user
  		return user
  	else
  		where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  			user.provider = auth.provider
  			user.uid = auth.uid
  			user.fullname = auth.info.name
  			user.email = auth.info.email
  			user.image = auth.info.image
  			user.password = Devise.friendly_token[0,20]
  		end	
  	end
  end

  #returns all the feedbacks left for a particular guest
  #can refactor to say Feedback.where(guest_id: 1)
  def feedbacks_for_me
    feedbacks = []
    self.reservations.each do |reservation|
      if reservation.feedback
        feedbacks << reservation.feedback
      end
    end

    return feedbacks
  end

  #returns true if the host has already left feedback for the guest
  def feedback_exists?(host)
    self.feedbacks_for_me.any? { |feedbacks| feedbacks.user_id == host.id }
  end

end
