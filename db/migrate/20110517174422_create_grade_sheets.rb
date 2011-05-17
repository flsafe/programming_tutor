class CreateGradeSheets < ActiveRecord::Migration
  def self.up
    create_table :grade_sheets do |t|
      t.integer :user_id
      t.integer :exercise_id
      t.float :grade
      t.text :tests
      t.text :src_code
      t.integer :time_taken

      t.timestamps
    end
  end

  def self.down
    drop_table :grade_sheets
  end
end
