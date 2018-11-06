class DashboardController < ApplicationController
  def index
    @language_user = LanguageUser.new
    @languages = current_user.languages

    @entries = Entry.where(user_id: current_user.id)
                    .order('id asc')
                    .last(5)
                    .map { |entry| 
                      DashboardEntryPresenter.new(entry) 
                    }
  end
end
