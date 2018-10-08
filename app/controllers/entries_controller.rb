class EntriesController < ApplicationController
  respond_to :html
  
  def new
    @form = EntryForm.new(user: current_user)
  end

  def create
    @form = EntryForm.new(entry_params.merge(user: current_user))
    @form.save

    respond_with(@form, location: dashboard_index_path)
  end

  private

  def entry_params
    params.require(:entry_form).permit(
      :duration, :duration_type, :language_studied,
      :notes, study_habits: []
    )
  end
end
