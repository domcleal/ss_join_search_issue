class CreateHosts < ActiveRecord::Migration
  def change
    create_table :hosts do |t|
      t.string :name
      t.integer :hostgroup_id

      t.timestamps null: false
    end
  end
end
