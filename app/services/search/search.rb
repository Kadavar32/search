# app/services/search/search.rb
module Searchable
  class Search
    class << self
      def invoke(data, q)
        high_precision = q.include?('"') or q.include?("'") # "search field" is something contcretical
        positive, negative = normalize_search_q(q) # group search string by positive and negative

        relevant_hash = {} # { language_name: relevant_priority_index }

        data.each do |key, data|
          relevant_priority_index = (positive - data).count
          next if relevant_priority_index == positive.count # no matches
          next if (negative - data).count != negative.count # matches with negative field
          relevant_hash[key] = relevant_priority_index
        end

        full_match = []
        relevant_hash.each do |key, relevant_index| # select all matches
          if relevant_index == 0
            full_match.push(key)
            relevant_hash.delete(key)
          end
        end

        other_results = if high_precision
                          []
                        else
                          relevant_hash.sort_by { |_key, index| index }.map(&:first)
                        end

        { full_match: full_match, other_results: other_results }
      end

      private

      def normalize_search_q(q)
        search_data = q.gsub('"', '').gsub("'", '').upcase.split(' ')
        negative = []
        positive = []

        search_data.each do |e|
          e.include?('-') ? negative.push(e.gsub('-', '')) : positive.push(e)
        end

        [positive, negative]
      end
    end
  end
end
