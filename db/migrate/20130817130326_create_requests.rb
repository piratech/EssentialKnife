class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.text :request_number
      t.text :note
      t.boolean :has_data, default: false
      t.text :state

      t.timestamps
    end
  end
end
