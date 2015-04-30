class Credit < ActiveRecord::Base

  attr_accessible :product_id, :user_id, :product, :user,
    :role, :credit_validations_count, :role_desc, :current_credit_role,
    :confirmed_validations_count, :credit_validation_id, :issue, :validator_id,
    :user_name, :current_credit_id, :fact, :credit_validations_attributes,
    :status, :pending_user_email, :count, :startdate, :enddate, :release,
    :category, :product_idd, :tag_list, :promoted, :source

  attr_accessor :current_credit_id, :current_credit_role, :product_idd 

  belongs_to :user, :counter_cache => true
  belongs_to :product, :counter_cache => true
  has_many :credit_validations, :dependent => :destroy
  has_many :posts, :dependent => :destroy
  accepts_nested_attributes_for :credit_validations, allow_destroy: true


  #validates_presence_of :role
  #validates_uniqueness_of :pending_user_email, :scope => [:credit_validation_id, :product_id ], :message => "A credit with this email and role has already been taken."
  #validates_uniqueness_of :user_id, :scope => [:role, :product_id], :message => "A credit with this email and role has already been taken."

  scope :confirmed, where(:status => "confirmed")
  scope :pending, where(:status => "pending")
  scope :cv_unverified, where(:credit_validations_count => "0")
  scope :cv_part, where(:confirmed_validations_count => "1 | 2")  
  scope :cv_confirmed, where(:confirmed_validations_count => "3")
  scope :user_pending, lambda { |user| where("credit.user_id = ?", user.id) }
  scope :wa_source, where(source: "wa")  

  scope :claimable, -> { where confirmed_validations_count: 0 }

  scope :most_recents, -> { confirmed.order('created_at ASC').limit(3) } 
  scope :recent, -> { confirmed.order('created_at ASC') }
  scope :uniq_user, -> { select('DISTINCT credits.user_id, *') } 

  delegate :name, to: :user

  def confirmed?
    status == "confirmed"
  end

  def pending?
    status == "pending"
  end

  def fact_short
    return fact[0, 50] + "..." if fact
    "..."
  end


  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Credit.create! row.to_hash
    end
  end

end
