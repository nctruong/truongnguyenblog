class AddContentFilteredToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :content_filtered, :text
  end
end
