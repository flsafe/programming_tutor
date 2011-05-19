class CreateCodeSessionsExercises < ActiveRecord::Migration
  def self.up
    create_table :code_sessions_exercises do |t|
      t.integer :user_id
      t.integer :exercise_id

      t.timestamps
    end
  end

  def self.down
    drop_table :code_sessions_exercises
  end
end
