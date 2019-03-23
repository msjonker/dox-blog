require 'csv'

class ArticlesImporter
  def self.import(path)
    CSV.foreach(path, headers: true) do |row|
      row_hash = row.to_hash
      body = JSON.parse(row_hash['body']).join("\n")
      article = Article.new row_hash.slice('title').merge(body: body, hero_image_name: row_hash['hero image'])
      article.author = Author.find_or_initialize_by(name: row_hash['author name'])
      article.save
    end
  end
end