module Api
  class EntriesController < ApiController
    respond_to :json

    def index
      respond_with EntriesSerializer.new(params.reverse_merge({
        user: current_user
      }))
    end
  end
end
