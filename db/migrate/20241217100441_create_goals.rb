class CreateGoals < ActiveRecord::Migration[6.1]
  def change
    create_table :goals do |t|
      t.string :title, null: false
      t.timestamps
    end
  end
end
