class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	
	### Associations
	has_many :posts, dependent: :destroy
	has_many :pcomments
	has_many :lcomments
	has_many :savetimetables

	### Scopes
	default_scope { where(active: true) }
end
