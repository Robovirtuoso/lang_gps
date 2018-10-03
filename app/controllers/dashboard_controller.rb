class DashboardController < ApplicationController
  def index
    @language_user = LanguageUser.new
    @languages = current_user.languages
  end
end
