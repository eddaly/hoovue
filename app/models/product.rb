class Product < ActiveRecord::Base
  attr_accessible :description, :genre, :video, :moderation_status, :startdate,
    :enddate, :credits_count, :image, :image_2, :image_3, :studio, :title,
    :year, :status, :user_id, :credits_attributes, :properties,
    :product_genre_id, :role, :role_description, :fact, :issue, :url,
    :remove_image, :image_cache, :date, :published_by, :developed_by, :released,
    :perspective, :non_sport, :misc, :platforms, :alternate_title, :categories,
    :groups, :indentifier, :esrb_rating, :sport, :educational

  attr_accessor :role, :role_description, :fact, :issue

  belongs_to :user
  has_many :credits, :dependent => :destroy
  belongs_to :product_genre
  serialize :properties, Hash
  accepts_nested_attributes_for :credits, :allow_destroy => true
  mount_uploader :image, ImageUploader
  mount_uploader :image_2, ImageUploader
  mount_uploader :image_3, ImageUploader

  validates :title, :presence => true

  scope :games, -> { where genre: "Game" }

  scope :most_popular, -> { where("credits_count IS NOT NULL").order("credits_count DESC").limit(3) }
  scope :most_recents, -> { where('credits_count > 0').order('products.created_at ASC').limit(3) } 

  scope :popular, -> { where("credits_count IS NOT NULL").order("credits_count DESC") }
  scope :recent, -> { where("credits_count IS NOT NULL").order("products.created_at ASC") }

  scope :top_five, -> { where("credits_count IS NOT NULL").order("credits_count DESC").limit(5) }

  def to_param
    "#{id} #{title}".parameterize
  end

  def can_buy_on_amazon?
    ["Game", "Film", "Comic"].include? genre
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Product.create! row.to_hash
    end
  end

  def self.search(search)
    if search
      games.where('title iLIKE :search OR genre iLIKE :search OR studio iLIKE :search', search: "%#{search}%".downcase)
    end
  end  

  def validate_properties
    product_genre.fields.each do |field|
      if field.required? && properties[field.name].blank?
        errors.add field.name, "must not be blank"
      end
    end
  end


end
