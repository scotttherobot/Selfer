class Comment < ActiveRecord::Base
   belongs_to :user
   belongs_to :post

   validates :body, presence: true
   validates_presence_of :user
   validates_presence_of :post
end
