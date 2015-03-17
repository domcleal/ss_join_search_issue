class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.integer :host_id

      t.timestamps null: false
    end
  end
end
