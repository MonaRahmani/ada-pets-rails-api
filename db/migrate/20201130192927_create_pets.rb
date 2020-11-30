class CreatePets < ActiveRecord::Migration[6.0]
  def change
    create_table :pets do |t|
      t.string :name
      t.integer :age
      t.string :specious
      t.string :owner

      t.timestamps
    end
  end
end
