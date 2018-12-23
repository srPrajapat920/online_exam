class ChangeColumnExam < ActiveRecord::Migration[5.2]
  def change
  	change_column :exams, :start_at, :datetime
  end
end
