class CreateHostgroups < ActiveRecord::Migration
  def change
    create_table :hostgroups do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
