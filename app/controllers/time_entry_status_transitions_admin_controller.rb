class TimeEntryStatusTransitionsAdminController < ApplicationController
  
  layout 'admin'
  
  def index
    @projects = Project.includes(:enabled_modules).where(:enabled_modules => {:name => 'time_tracking'})
    @activities_for_select = Enumeration.where(:type => "TimeEntryActivity").where("(#{Enumeration.table_name}.project_id is null) or (#{Enumeration.table_name}.project_id = '#{@projects.first.id}')")
  end

  def create
    activity = params.require(:time_entry_status_transition).permit(:project, :issue_status, :activity_id)
    if activity
      @activity = TimeEntryStatusTransition.new
      @activity[:issue_status_id] = activity[:issue_status]
      @activity[:project_id] = activity[:project]
      @activity[:activity_id] = activity[:activity_id]
      if @activity.save
        flash[:notice] = l(:time_logger_settings_activity_add_success)
        redirect_to time_entry_status_transitions_admin_index_path
      else
        flash[:error] = l(:time_logger_settings_activity_add_failed)
        redirect_to :back
      end
    end
  end

  def destroy
    @activity = TimeEntryStatusTransition.find(params.require(:id))
    unless @activity.nil?
      if @activity.destroy
        flash[:notice] = l(:time_logger_settings_activity_delete_success)
        redirect_to time_entry_status_transitions_admin_index_path
      else
        flash[:error] = l(:time_logger_settings_activity_delete_failed)
        redirect_to :back
      end
    end
  end

  def update_activities
    project_id = params.require(:project_id)
    @activities_for_select = Enumeration.where(:type => "TimeEntryActivity").where("(#{Enumeration.table_name}.project_id is null) or (#{Enumeration.table_name}.project_id = '#{project_id}')")
    respond_to do |format|
      format.js
    end
  end

end