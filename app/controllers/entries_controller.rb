class EntriesController < ApplicationController
  respond_to :html

  def index
    @entries = Entry.where(user_id: current_user.id)
                    .order('id asc')
                    .last(5)
                    .map { |entry| 
                      DashboardEntryPresenter.new(entry) 
                    }
  end
  
  def new
    @form = EntryForm.new(user: current_user)
  end

  def create
    @form = EntryForm.new(create_entry_params.merge(user: current_user))
    @form.save

    respond_with(@form, location: dashboard_index_path)
  end

  def edit
    @form = EditEntryForm.new(
      user: current_user,
      entry: current_user.entries.where(id: params[:id]).first
    )
  end

  def update
    @form = EditEntryForm.new(edit_entry_params.merge(
      user: current_user,
      entry: current_user.entries.where(id: params[:id]).first
    ))

    @form.save

    respond_with(@form, location: entries_path)
  end

  def destroy
    entry = Entry.find(params[:id])
    entry.destroy

    respond_with(200, location: entries_path)
  end

  private

  def edit_entry_params
    params.require(:edit_entry_form).permit(
      :language_studied, :duration, :duration_type,
      :study_habit, :notes
    )
  end

  def create_entry_params
    params.require(:entry_form).permit(
      :language_studied, :notes, entries: [
        :duration, :duration_type, :study_habit
      ]
    )
  end
end
