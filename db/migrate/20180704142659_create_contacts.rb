class CreateContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts do |t|
      t.string :name
      t.datetime :birth
      t.string :email
      t.string :phone
      t.string :picture

      t.timestamps
    end
  end
end
