# app/services/search/response_decorator.rb
module Searchable
  class ResponseDecorator
    class << self
      def invoke(input_data, result)
        select = ->(type) do
          input_data.reverse.select{ |e| result[type].include? e['name'] }
        end
        # input_data.reverse is "relevant" sort trick, example: lisp => lisp, common lisp

        { full_match: select.call(:full_match), other_results: select.call(:other_results) }
      end
    end
  end
end
