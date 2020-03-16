class CreateOkays < ActiveRecord::Migration[6.0]
  def change
    create_table :okays do |t|
      t.integer :owner_id
      t.boolean :okay_or_not

      t.timestamps
    end
  end
end
