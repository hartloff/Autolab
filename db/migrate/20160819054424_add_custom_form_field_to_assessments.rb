class AddCustomFormFieldToAssessments < ActiveRecord::Migration
  def up
      add_column :assessments, :has_custom_form, :boolean
  end
  
  def down
      remove_column :assessments, :has_custom_form
  end
end
