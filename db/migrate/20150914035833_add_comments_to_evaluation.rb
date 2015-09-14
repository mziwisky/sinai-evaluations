class AddCommentsToEvaluation < ActiveRecord::Migration
  def change
    add_column :evaluations, :comments, :text
  end
end
