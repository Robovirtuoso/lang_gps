class LanguageUsersController < ApplicationController

  def create
    LanguageUser.create(language_association)
    redirect_to dashboard_index_path
  end

  private

  def language_association
    Array(lang_user_params[:language_id]).map do |id|
      { language_id: id, user_id: current_user.id }
    end
  end

  def lang_user_params
    params.require(:language_user).permit(language_id: [])
  end
end
