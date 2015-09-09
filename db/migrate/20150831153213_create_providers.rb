class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.text :name, :null => false
      t.text :email, :null => false
      t.boolean :disabled

      t.timestamps
    end
  end
end
