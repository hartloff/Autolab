class AddGraderToSubmission < ActiveRecord::Migration
  def up
      add_column :submissions, :grader, :string
  end
  
  def down
      remove_column :submissions, :grader
  end
end
