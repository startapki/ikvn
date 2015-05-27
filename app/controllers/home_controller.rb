class HomeController < ApplicationController
  def index
    @leagues = League.includes(tournaments: { seasons: :tours }).all
  end
end
