class CreateDrivePlaces < ActiveRecord::Migration[5.2]
  def change
    create_table :drive_places do |t|
      t.string :code, null: false, unique: true
      t.string :section_type
      t.string :name
      t.float :lat, null: false, default: 0
      t.float :lon, null: false, default: 0
      t.string :prefecture
      t.string :city
      t.string :postal_code
      t.string :address, null: false
      t.string :tel
      t.text :extra_infos
      t.text :options
      t.timestamps
    end
  end
end
