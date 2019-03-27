require 'active_support/concern'

module Searchable
  extend ActiveSupport::Concern

  included do
    scope :containing_query, -> (attributes, query) do
      tokens = Searchable.tokenize query
      Array(attributes).map { |attribute|
        token_clauses = tokens.map do |term|
          self.arel_table[attribute].matches("%#{term}%")
        end.reduce(:or)
        where(token_clauses)
      }.reduce(:or)
    end

    def search_score(attributes, query)
      tokens = Searchable.tokenize query
      search_regex = Searchable.to_word_delimited_regex tokens
      attributes.map do |attribute|
        Searchable.score self[attribute], search_regex
      end.reduce(:+)
    end
  end

  class_methods do
    def search(relation, attributes, query)
      Hash[relation.containing_query(attributes, query).map do |object|
        [object, object.search_score(attributes, query)]
      end].sort_by {|_key, value| value * -1}.to_h.keys
    end
  end

  def self.tokenize(text)
    text.scan(/\w+/)
  end

  # https://www.elastic.co/guide/en/elasticsearch/guide/current/scoring-theory.html#tf
  def self.term_frequency(frequency)
    Math.sqrt(frequency)
  end

  # https://www.elastic.co/guide/en/elasticsearch/guide/current/scoring-theory.html#field-norm
  def self.field_length_norm(term_count)
    1/Math.sqrt(term_count)
  end

  def self.to_word_delimited_regex(tokens)
    token_regexes = tokens.map(&:downcase).uniq.map {|token| Regexp.new(Regexp.escape(token), Regexp::IGNORECASE) }
    /\b#{Regexp.union(token_regexes)}\b/i
  end

  def self.score(text, search_regex)
    return 0 if text.blank?
    term_count = Searchable.tokenize(text).length
    matches = text.scan(search_regex)
    return 0 if matches.empty?
    match_counts = Hash[matches.group_by(&:itself).map {|k,v| [k, v.length]}]
    match_counts.values.map do |frequency|
      Searchable.term_frequency(frequency) * Searchable.field_length_norm(term_count)
    end.reduce(:+)
  end
end