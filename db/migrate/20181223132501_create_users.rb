# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :contact_no
      t.string :email_id
      t.string :password_hash
      t.string :password_salt
      t.string :level
      t.boolean :admin, default: false
      t.timestamps
    end
  end
end
