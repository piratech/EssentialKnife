class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.text :request_number
      t.text :note
      t.boolean :has_data, default: false
      t.text :state

      #data
      t.text :name
      t.text :vorname
      t.text :strasse
      t.text :plz
      t.text :ort
      t.text :email
      t.text :newsletter
      t.text :b1
      t.text :b2
      t.text :b3
      t.text :b4
      t.text :b5
      t.text :b6
      t.text :b7
      t.text :b8
      t.text :b9
      t.text :b10
      t.text :vberuf
      t.text :vname
      t.date :date
      t.text :version
      t.text :complete

      t.timestamps
    end
  end
end
