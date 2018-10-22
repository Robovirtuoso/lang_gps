module Api
  class EntriesController < ApiController
    respond_to :json

    def index
      respond_with EntriesSerializer.new(params.reverse_merge({
        user_id: current_user.id
      }))
    end
  end
end
