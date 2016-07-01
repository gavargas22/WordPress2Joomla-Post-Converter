class Post < ActiveRecord::Base

	# Connect to the remote database for now, it is hard coded.
	WP_DB = Sequel.connect(:adapter => 'mysql2', :user => 'redacted', :password => "redacted", :host => "redacted" , :database => "db")
	J_DB = Sequel.connect(:adapter => 'mysql2', :user => 'db_user', :password => "redacted", :host => "redacted" , :database => "db")
	# Connect to the posts table

	def self.create_entries
		wp_posts = WP_DB.from(:db_prefix_posts)
		# Execute the following block on each of the items in db.
		wp_posts.each do |wp_post|
			# Look for an existing post in the database.
			# joomla_converted_post = Post.find_by(post_title: wp_post[:post_title])
			# If the post was not found above, then create a new one.
			joomla_converted_post = Post.new #if joomla_converted_post.nil?
			# Eliminate the parameters that have no equal in the database
			cleaned_wp_post = wp_post.except(:ID, :post_author, :comment_status, :ping_status, :post_password, :to_ping, :pinged, :post_modified, :post_modified_gmt, :post_content_filtered, :post_parent, :menu_order, :comment_count)
			# Assing values in attributes present in the cleaned_wp_post to the joomla_converted_post
			joomla_converted_post.attributes = cleaned_wp_post.slice(*cleaned_wp_post.keys)
			# Save new post to local database
			joomla_converted_post.save!
		end
	end

	# Inject Posts

	def self.inject_converted_posts
		# Connect to the Joomla posts (content) database
		j_posts = J_DB.from(:db_prefix_content)

		@posts = Post.where(:post_type => "post", :post_status => "publish")
		@posts.each do |wp_post|

			j_posts.insert(:id => j_posts.order(:id).last[:id] + 1, :asset_id => j_posts.order(:asset_id).last[:asset_id] + 1, :title => wp_post.post_title, :alias => wp_post.post_title.downcase.gsub(/\s+/, '-'), :introtext => wp_post.post_content, :fulltext => '', :state => '1', :catid => '14', :created => wp_post.post_date, :created_by => '406', :created_by_alias => 'Joomla', :modified => wp_post.post_date, :modified_by => '713', :checked_out => '0', :checked_out_time => '0000-00-00 00:00:00', :publish_up => wp_post.post_date, :publish_down => '0000-00-00 00:00:00', :images => '{"image_intro":"","float_intro":"","image_intro_alt":"","image_intro_caption":"","image_fulltext":"","float_fulltext":"","image_fulltext_alt":"","image_fulltext_caption":""}', :urls => '', :attribs => '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_vote":"","show_hits":"","show_noauth":"","alternative_readmore":"","article_layout":"","show_publishing_options":"","show_article_options":"","show_urls_images_backend":"","show_urls_images_frontend":""}', :version => '2', :ordering => '2', :metakey => '', :metadesc => '', :access => '1', :hits => '16', :metadata => '{"robots":"","author":"","rights":"","xreference":""}', :featured => '0', :language => '*', :xreference => '')
		end
	end


	# :id, :asset_id, :title, :alias, :introtext, :fulltext, :state, :catid, :created, :created_by, :created_by_alias, :modified, :modified_by, :checked_out, :checked_out_time, :publish_up, :publish_down, :images, :urls, :attribs, :version, :ordering, :metakey, :metadesc, :access, :hits, :metadata, :featured, :language, :xreference

	# j_posts.insert(:id => 8, :asset_id => '45', :title => 'Hello from RB', :alias => '', :introtext => 'Post from RB', :fulltext => 'From RB', :state => '-2', :catid => '2', :created => '2011-01-01 00:00:01', :created_by => '406', :created_by_alias => 'Joomla', :modified => '2013-10-13 17:16:12', :modified_by => '713', :checked_out => '0', :checked_out_time => '0000-00-00 00:00:00', :publish_up => '2012-01-04 16:48:38', :publish_down => '0000-00-00 00:00:00', :images => '{"image_intro":"","float_intro":"","image_intro_alt":"","image_intro_caption":"","image_fulltext":"","float_fulltext":"","image_fulltext_alt":"","image_fulltext_caption":""}', :urls => '', :attribs => '{"show_title":"","link_titles":"","show_intro":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_vote":"","show_hits":"","show_noauth":"","alternative_readmore":"","article_layout":"","show_publishing_options":"","show_article_options":"","show_urls_images_backend":"","show_urls_images_frontend":""}', :version => '2', :ordering => '2', :metakey => '', :metadesc => '', :access => '1', :hits => '16', :metadata => '{"robots":"","author":"","rights":"","xreference":""}', :featured => '0', :language => '*', :xreference => '')


end
