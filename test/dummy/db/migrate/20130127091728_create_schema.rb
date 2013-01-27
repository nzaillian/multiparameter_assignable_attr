class CreateSchema < ActiveRecord::Migration
  def change
    create_table :a_models do |t|
      t.datetime :start_date

      t.timestamps
    end
  end
end
