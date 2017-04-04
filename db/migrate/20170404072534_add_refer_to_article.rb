class AddReferToArticle < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :ref_url, :string
  end
end
