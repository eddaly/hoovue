class Creditsplatforms < ActiveRecord::Base
  attr_accessible :credit_id, :platform_id
  belongs_to :credit
  belongs_to :platforms
end
