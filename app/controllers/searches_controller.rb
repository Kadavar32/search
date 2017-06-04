# /app/controllers/search_controller.rb

class SearchesController < ApplicationController
  def create
    @result = [{ name: 'Name', type: 'Type', designed_by: 'designed by' }.with_indifferent_access]
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
end