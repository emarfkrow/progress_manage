class CreateActualHolidays < ActiveRecord::Migration[5.2]
  def change
    create_table :actual_holidays do |t|
      t.date :holiday
    end
  end
end
