class RemoveStudentSchoolEmail < ActiveRecord::Migration[7.2]
  def change
    remove_column :students, :school_email, :string
  end
end
