class CreateMyControllers < ActiveRecord::Migration
  def change
    create_table :my_controllers do |t|
      t.string :name
      t.string :attachement

      t.timestamps null: false
    end
  end
end
