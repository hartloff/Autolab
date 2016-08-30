class AddTextfieldsToAssessment < ActiveRecord::Migration
    def up
        add_column :assessments, :textfields, :text
    end
    
    def down
        remove_column :assessments, :textfields
    end
end
