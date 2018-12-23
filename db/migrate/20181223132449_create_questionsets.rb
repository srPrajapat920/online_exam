# frozen_string_literal: true

class CreateQuestionsets < ActiveRecord::Migration[5.2]
  def change
    create_table :questionsets do |t|
      t.references :subject, index: true, foreign_key: true
      t.string :name
      t.string :level
      t.integer :time
      t.integer :no_ques
      t.boolean :is_active
      t.integer :marks_per_ques
      t.timestamps
    end
  end
end
