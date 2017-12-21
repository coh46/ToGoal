class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :subject
      t.text :content

      t.timestamps null: false
    end
  end
end
