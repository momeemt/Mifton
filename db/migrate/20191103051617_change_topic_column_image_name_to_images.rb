class ChangeTopicColumnImageNameToImages < ActiveRecord::Migration[5.2]
  def change
    remove_column :topics, :image_name
  end
end
