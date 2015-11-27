class AddAccessCodeToProvider < ActiveRecord::Migration
  def up
    add_column :providers, :access_code, :text
    add_index :providers, :access_code

    Provider.all.each do |p|
      p.access_code = SecureRandom.uuid
      p.save!
    end
  end

  def down
    remove_column :providers, :access_code
  end
end
