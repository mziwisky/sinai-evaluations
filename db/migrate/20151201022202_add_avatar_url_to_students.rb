class AddAvatarUrlToStudents < ActiveRecord::Migration
  def up
    add_column :students, :avatar_url, :text
  end

  def down
    remove_column :students, :avatar_url
  end
end
