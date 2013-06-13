class Post < ActiveRecord::Base
  attr_accessible :body, :title, :credit_id
    belongs_to :credit
    validates_presence_of :body
end
