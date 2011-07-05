class CreateLessonCertificates < ActiveRecord::Migration
  def self.up
    create_table :lesson_certificates do |t|
      t.integer :lesson_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :lesson_certificates
  end
end
