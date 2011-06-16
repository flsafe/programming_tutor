class AddTimeoutErrorToGradeSheets < ActiveRecord::Migration
  def self.up
    add_column :grade_sheets, :timeout_error, :boolean
  end

  def self.down
    remove_column :grade_sheets, :timeout_error
  end
end
