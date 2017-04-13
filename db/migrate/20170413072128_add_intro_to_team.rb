class AddIntroToTeam < ActiveRecord::Migration[5.0]
  def change
    add_column :teams, :intro, :string
  end
end
