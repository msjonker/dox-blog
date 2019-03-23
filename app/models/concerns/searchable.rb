require 'active_support/concern'

module Searchable
  extend ActiveSupport::Concern

  included do
    scope :containing_text, -> (attributes, query) do
      tokens = tokenize query
      Array(attributes).map { |attribute|
        token_clauses = tokens.map do |term|
          self.arel_table[attribute].matches("%#{term}%")
        end.reduce(:or)
        where(token_clauses)
      }.reduce(:or)
    end
  end

  class_methods do
    def search(relation, query, attribute_config)
      Hash[relation.containing_text(attribute_config.keys, query).map do |model|
        tokens = tokenize query
        ngrams = ngrams tokens
        score = attribute_config.map do |attribute, config|
          ngrams.map do |term|
            model[attribute].scan(/(?=#{term.join(' ')})/).count * term.length * (config[:boost] || 1)
          end.reduce(:+)
        end.reduce(:+)
        [model, score]
      end].sort_by {|_key, value| value * -1}.to_h.keys
    end

    def tokenize(text)
      text.scan(/\w+/)
    end

    def ngrams(tokens)
      (0...tokens.length).map do |i|
        (i...tokens.length).map do |j|
          tokens[i..j]
        end
      end.flatten(1)
    end
  end
end