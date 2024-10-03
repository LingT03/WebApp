class AddMinorToStudents < ActiveRecord::Migration[7.2]
  def change
    add_column :students, :minor, :string
  end
end
