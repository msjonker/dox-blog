require 'will_paginate/array'

class Article < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

  include Searchable


  belongs_to :author
  validates :author, :title, :body, presence: true

  scope :published, -> { where(published: true).order("created_at desc") }
  scope :featured, -> { where(published: true).where(featured: true).order("id desc") }

  def self.import(file)
    require 'csv'

    CSV.foreach(file.path, headers: true) do |row|
      row_hash = row.to_hash
      body = JSON.parse(row_hash['body']).join("\n")
      article = Article.new row_hash.slice('title').merge(body: body, hero_image_name: row_hash['hero image'])
      article.author = Author.find_or_initialize_by(name: row_hash['author name'])
      article.save
    end
  end
end
