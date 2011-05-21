class CreateCodeSessions < ActiveRecord::Migration
  def self.up
    create_table :code_sessions do |t|
      t.integer :exercise_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :code_sessions
  end
end
