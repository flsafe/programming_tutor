class AddImageUrlToLesson < ActiveRecord::Migration
  def self.up
    add_column :lessons, :image_url, :string, :default => ""
  end

  def self.down
    remove_column :lessons, :image_url
  end
end
