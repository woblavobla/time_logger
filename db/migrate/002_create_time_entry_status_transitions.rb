class CreateTimeEntryStatusTransitions < ActiveRecord::Migration
  def self.up
    create_table :time_entry_status_transitions do |t|
      t.belongs_to :project
      t.belongs_to :issue_status
      t.column :activity_id, :integer
    end
  end

  def self.down
    drop_table :time_entry_status_transitions
  end
end
