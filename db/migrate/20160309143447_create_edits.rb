class CreateEdits < ActiveRecord::Migration
  def change
    create_table :edits do |t|
      t.text :content
      t.references :post, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :edits, [:post_id, :created_at]
  end
end
