class Category < ActiveRecord::Base

	# Connect to the remote database for now, it is hard coded.
	WP_DB = Sequel.connect(:adapter => 'mysql2', :user => 'redacted', :password => "redacted", :host => "redacted" , :database => "db")
	J_DB = Sequel.connect(:adapter => 'mysql2', :user => 'db_user', :password => "redacted", :host => "redacted" , :database => "db")
	# Connect to the posts table

	# Get Categories from Wordpress
	def self.create_categories
		wp_categories = WP_DB.from(:db_prefix_terms).where(Sequel.like(:name, "%RDSN%"))

		wp_categories.each do |category|
			category_object = Category.new
			category_object.name = category[:name].scan(/(?<!\w)RDSN_(.+)/).collect(&:first).first
			category_object.term_id = category[:term_id]
			category_object.slug = category[:slug]
			category_object.save!
		end
	end

	def self.inject_converted_categories
		j_categories = J_DB.from(:db_prefix_categories)

		@categories = Category.all
		@categories.each do |c|
			j_categories.insert(:id => j_categories.order(:id).last[:id] + 1, :asset_id => j_categories.order(:asset_id).last[:asset_id] + 1, :parent_id => 14, :title => c.name, :extension => "com_content", :alias => c.name.downcase, :description => "", :params => '{\"category_layout\":\"\",\"image\":\"\",\"image_alt\":\"\"}', :metadesc => "", :metakey => "", :metadata => '{\"author\":\"\",\"robots\":\"\"}', :created_user_id => 216, :created_time => '0000-00-00 00:00:00', :modified_user_id => 0, :modified_time => '2016-01-01 14:32:08', :hits => 0, :language => "*", :version => 1)
		end
	end

end

# {:id=>j_categories.order(:id).last[:id] + 1, :asset_id=>j_categories.order(:asset_id).last[:asset_id] + 1, :parent_id=>14, :lft=>13, :rgt=>14, :level=>1, :path=>"news", :extension=>"com_content", :title=>"News", :alias=>"news", :note=>"", :description=>"", :published=>true, :checked_out=>0, :checked_out_time=>nil, :access=>1, :params=>"{\"category_layout\":\"\",\"image\":\"\",\"image_alt\":\"\"}", :metadesc=>"", :metakey=>"", :metadata=>"{\"author\":\"\",\"robots\":\"\"}", :created_user_id=>216, :created_time=>2016-01-01 14:32:08 +0800, :modified_user_id=>0, :modified_time=>2016-01-01 14:32:08 +0800, :hits=>0, :language=>"*", :version=>1}
