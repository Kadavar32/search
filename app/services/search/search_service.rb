# /app/services/search/search_service.rb
module Searchable
  class SearchService
    class << self
      def invoke(q)
        parsed_data, search_data = Searchable::DataParser.invoke
        search_result = Searchable::Search.invoke(search_data, q)
        Searchable::ResponseDecorator.invoke(parsed_data, search_result)
      end
    end
  end
end