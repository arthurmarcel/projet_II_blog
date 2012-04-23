class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
			t.string :author
			t.integer :post_id
      t.text :body
      t.timestamps
    end
  end
end
