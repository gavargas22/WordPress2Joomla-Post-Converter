class CreatePosts < ActiveRecord::Migration
	def change
		create_table :posts do |t|
			t.datetime :post_date
			t.datetime :post_date_gmt
			t.text :post_content
			t.string :post_title
			t.string :post_excerpt
			t.string :post_status
			t.string :post_name
			t.string :guid
			t.string :post_type
			t.string :post_mime_type

			t.timestamps null: false
		end
	end
end
