class CreateScans < ActiveRecord::Migration
  def change
    create_table :scans do |t|
      t.integer :request_id
      t.text :file
      t.text :request_number
      t.text :data
      t.text :barcode
      t.text :note
      t.boolean :deleted, default: false

      t.timestamps
    end
  end
end
