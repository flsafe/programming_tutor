class CreateBadges < ActiveRecord::Migration
  def self.up
    create_table :badges do |t|
      t.string :title
      t.string :description
      t.string :earn_conditions
      t.string :image_url

      t.timestamps
    end
  end

  def self.down
    drop_table :badges
  end
end
