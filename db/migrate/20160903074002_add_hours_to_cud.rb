class AddHoursToCud < ActiveRecord::Migration
    def up
        add_column :course_user_data, :hours, :integer
    end
    
    def down
        remove_column :course_user_data, :hours
    end
end
