class CreateIdeaImages < ActiveRecord::Migration
  def change
    create_table :idea_images do |t|
      t.references :idea, index: true
      t.references :image, index: true

      t.timestamps null: false
    end
    add_foreign_key :idea_images, :ideas
    add_foreign_key :idea_images, :images
  end
end
