class CreateProjects < ActiveRecord::Migration[7.1]
  def change
    create_table :projects do |t|
      t.string :title
      t.string :category
      t.string :status
      t.string :tools, array: true
      t.string :materials, array: true
      t.text :methodology
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
