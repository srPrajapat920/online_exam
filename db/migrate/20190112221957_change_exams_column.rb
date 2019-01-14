class ChangeExamsColumn < ActiveRecord::Migration[5.2]
  def change
  	change_column :exams, :start_at, :string
  end
end
