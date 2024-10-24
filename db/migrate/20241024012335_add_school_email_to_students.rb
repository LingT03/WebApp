class AddSchoolEmailToStudents < ActiveRecord::Migration[7.2]
  def change
    add_column :students, :school_email, :string
  end
end
