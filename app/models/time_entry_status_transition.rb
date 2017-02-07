class TimeEntryStatusTransition < ActiveRecord::Base
  belongs_to :project
  belongs_to :issue_status, :class_name => 'IssueStatus'

  validates_uniqueness_of :project_id, :scope => [:issue_status_id, :activity_id]
  validates_presence_of :project_id, :issue_status_id, :activity_id

  def activity_by_id
    Enumeration.find(activity_id)
  end
end