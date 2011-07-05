class CreateCourseCertificates < ActiveRecord::Migration
  def self.up
    create_table :course_certificates do |t|
      t.integer :user_id
      t.integer :course_id

      t.timestamps
    end
  end

  def self.down
    drop_table :course_certificates
  end
end
