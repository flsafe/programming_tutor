class RemoveBooleansFromGradeSheet < ActiveRecord::Migration
  def self.up
    remove_column :grade_sheets, :syntax_error
    remove_column :grade_sheets, :timeout_error 
  end

  def self.down
    add_column :grade_sheets, :syntax_error
    add_column :grade_sheets, :timeout_error 
  end
end
