class CreateSolutionTemplates < ActiveRecord::Migration
  def self.up
    create_table :solution_templates do |t|
      t.integer :exercise_id
      t.string :src_language
      t.text :src_code

      t.timestamps
    end
  end

  def self.down
    drop_table :solution_templates
  end
end
