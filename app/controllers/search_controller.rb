# app/controllers/search_controller.rb
class SearchController < ApplicationController

  def search
    @result = Searchable::Search.invoke(search_params)
  rescue
     @result = { error: true }
  ensure
    respond_to do |format|
      format.html
      format.js
    end
 end

  private

  def search_params
    params.require(:q)
  end

end