class ChangeToolsAndMaterialsInProjects < ActiveRecord::Migration[7.1]
  def change
    remove_column :projects, :tools , :string, array: true
     remove_column :projects, :materials , :string, array: true
     add_column :projects, :tools, :text
      add_column :projects, :materials, :text
  end
end
