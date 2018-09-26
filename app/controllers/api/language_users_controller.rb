module Api
  class LanguageUsersController < ApiController

    def index
      languages = Language.joins(:language_users).where(
        "language_users.user_id": current_user.id
      )

      render json: languages
    end

  end
end
