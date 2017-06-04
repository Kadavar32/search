# app/services/search/data_parser.rb
module Searchable
  class DataParser
    class << self
      def invoke
        cache = ActiveSupport::Cache::MemoryStore.new
        parsed_data = cache.fetch(:parsed_data) do #
          parsed_data = JSON.parse(File.read('data.json'))
          parsed_data.map! { |e| Hash[e.map{|k,v| [k.downcase,v] }] } # keys like Name is not Rails way
        end

        search_data = cache.fetch(:search_data) do
          tmp = parsed_data.inject({}) do |hash,e|
            # move all relement data into array with strings
            element_data = (e.values.map { |e| e.gsub(',','').upcase.split(' ').flatten }).flatten
            hash.merge({ e['name'] => element_data })
          end
          tmp.sort_by { |k, _v| k.length }.to_h     # "relevant" sort trick, example: lisp => lisp, common lisp
        end

        [parsed_data, search_data]
      end
    end
  end
end