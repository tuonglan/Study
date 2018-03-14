#
# Cookbook Name:: nodes
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

begin
	search("node", "*:*").each do |matching_node|
		log matching_node.to_s
	end
rescue Exception => e
	puts "========= Error: " << e.message
end


begin
	search("users", "*:*").each do |user_data|
		user user_data["id"] do
			comment user_data["comment"]
			uid user_data["uid"]
			gid user_data["gid"]
			home user_data["home"]
			shell user_data["shel"]
		end
	end
rescue
	puts "========== Error: We can't find any account on the bags =========="
end
