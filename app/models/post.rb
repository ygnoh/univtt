class Post < ActiveRecord::Base
    has_many :pcomments
    belongs_to :user
end
