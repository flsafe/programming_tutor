class AddNumberToLesson < ActiveRecord::Migration
  def self.up
    add_column :lessons, :number, :integer
  end

  def self.down
    remove_column :lessons, :number
  end
end
