class Post < ActiveRecord::Base
    has_many :pcomments
    belongs_to :user

    default_scope { order(created_at: :desc) }
end
