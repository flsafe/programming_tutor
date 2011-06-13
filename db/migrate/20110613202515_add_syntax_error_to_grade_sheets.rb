class AddSyntaxErrorToGradeSheets < ActiveRecord::Migration
  def self.up
    add_column :grade_sheets, :syntax_error, :boolean
  end

  def self.down
    remove_column :grade_sheets, :syntax_error
  end
end
