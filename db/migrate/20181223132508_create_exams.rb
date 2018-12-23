# frozen_string_literal: true

class CreateExams < ActiveRecord::Migration[5.2]
  def change
    create_table :exams do |t|
      t.references :questionset, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.string :username
      t.string :email_id
      t.string :question_set
      t.date :start_at
      t.integer :attended_ques
      t.integer :total_marks
      t.timestamps
    end
  end
end
