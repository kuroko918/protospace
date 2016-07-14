class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string     :image
      t.integer    :status
      t.references :prototype
      t.timestamps
    end
  end
end
