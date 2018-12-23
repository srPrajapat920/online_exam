# frozen_string_literal: true

class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.references :questionset, index: true, foreign_key: true
      t.string :name
      t.string :option_a
      t.string :option_b
      t.string :option_c
      t.string :option_d
      t.string :ans
      t.string :ques_type
      t.boolean :is_active
      t.timestamps
    end
  end
end
