class CreateActualSpans < ActiveRecord::Migration[5.2]
  def change
    create_table :actual_spans do |t|
      t.integer :issue_id
      t.integer :bo_days
      t.date :bo_date
      t.integer :days
      t.integer :suspends
      t.integer :man_days
      t.date :eo_date
      t.integer :eo_days
    end
  end
end
