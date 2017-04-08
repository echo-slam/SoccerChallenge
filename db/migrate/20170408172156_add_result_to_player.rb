class AddResultToPlayer < ActiveRecord::Migration[5.0]
  def change
    add_column :players, :win, :integer
    add_column :players, :loss, :integer
    add_column :players, :draw, :integer
  end
end
