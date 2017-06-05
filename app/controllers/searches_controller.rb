# /app/controllers/search_controller.rb

class SearchesController < ApplicationController
  def create
    @result = Searchable::SearchService.invoke(search_params)
  rescue => exc
    puts exc.message
    @result = { error: true }
  ensure
    respond_to do |format|
      format.html
      format.js
    end
  end

  def  new

  end

  private

  def search_params
    params.require(:q)
  end
end