class AddDescriptionToSteps < ActiveRecord::Migration[8.0]
  def change
    add_column :steps, :description, :text
  end
end
