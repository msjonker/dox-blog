class Article < ActiveRecord::Base
  include Searchable
  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

  belongs_to :author
  validates :author, :title, :body, presence: true

  scope :published, -> { where(published: true).order("created_at desc") }
  scope :featured, -> { where(published: true).where(featured: true).order("id desc") }
end
