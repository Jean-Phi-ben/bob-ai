class AddPromptColumnToProjects < ActiveRecord::Migration[7.1]
  def change
    add_column :projects, :prompt, :text
  end
end
