@auth_hash = {
  "provider"=>"khan_academy",
  "uid"=>"http://id.khanacademy.org/15b519de09734e89bfdda7e95e5f0c03",
  "info"=>{"email"=>"johnschulz75@gmail.com", "nickname"=>"John Schulz", "name"=>"John Schulz"},
  "credentials"=>{"token"=>"t5939035316682752", "secret"=>"mwMbYS4aZSPYWWDN"},
  "extra"=> {
    "access_token"=> {
      "token"=>"t5939035316682752",
      "secret"=>"mwMbYS4aZSPYWWDN",
      "consumer"=> {
        "key"=>"UHze9rM6n5NtNee2",
        "secret"=>"f9Z24DkmGTyWZx5E",
        "options"=>{
          :signature_method=>"HMAC-SHA1",
          :request_token_path=>"/api/auth/request_token",
          :authorize_path=>"/oauth/authorize",
          :access_token_path=>"/api/auth/access_token",
          :proxy=>nil,
          :scheme=>:header,
          :http_method=>:get,
          :oauth_version=>"1.0",
          :site=>"http://www.khanacademy.org"
        },
        "http"=>Net::HTTP.new("www.khanacademy.org", 80),
        "http_method"=>:get,
      },
      "params"=>{
        :oauth_token=>"t5939035316682752",
        "oauth_token"=>"t5939035316682752",
        :oauth_token_secret=>"mwMbYS4aZSPYWWDN",
        "oauth_token_secret"=>"mwMbYS4aZSPYWWDN"
      },
    },
    "raw_info"=>{"spawned_by"=>nil, "students_count_temp"=>0, "can_record_tutorial"=>false, "is_demo"=>false, "is_parent"=>false, "creator"=>false, "total_seconds_watched"=>2198, "tos_accepted"=>20130321, "joined"=>"2015-03-06T03:58:13Z", "key_email"=>"http://id.khanacademy.org/15b519de09734e89bfdda7e95e5f0c03", "has_changed_avatar"=>true, "is_pre_phantom"=>false, "developer"=>false, "first_visit"=>"2015-03-06T03:55:57Z", "user_id"=>"http://id.khanacademy.org/15b519de09734e89bfdda7e95e5f0c03", "may_be_child"=>false, "title"=>nil, "all_proficient_exercises"=>[], "students_count"=>0, "student_summary"=>{"username"=>"nimylian", "nickname"=>"John Schulz", "email"=>"johnschulz75@gmail.com", "key"=>"ag5zfmtoYW4tYWNhZGVteXJUCxIIVXNlckRhdGEiRnVzZXJfaWRfa2V5X2h0dHA6Ly9pZC5raGFuYWNhZGVteS5vcmcvMTViNTE5ZGUwOTczNGU4OWJmZGRhN2U5NWU1ZjBjMDMM"}, "url_segment"=>"nimylian", "capabilities"=>[], "UNKNOWN_CLASSROOM_STATUS"=>2, "profile_root"=>"/profile/nimylian/", "avatar_url"=>"https://www.kastatic.org/images/avatars/svg/leaf-green.svg", "coworkers"=>[], "follow_requires_approval"=>true, "discussion_banned"=>false, "CLASSROOM_USER"=>1, "homepage"=>"learner", "email"=>"johnschulz75@gmail.com", "username"=>"nimylian", "last_badge_review"=>"2015-03-09T08:14:57Z", "is_midsignup_phantom"=>false, "registration_date"=>"2015-03-06T03:59:03Z", "points"=>13568, "coaches"=>[], "last_modified_as_mapreduce_epoch"=>3232, "is_child_account"=>false, "user_language"=>nil, "phantom_creation_date"=>nil, "uservideocss_version"=>0, "start_consecutive_activity_date"=>"2015-03-08T01:47:38Z", "nickname"=>"John Schulz", "teacher"=>false, "is_inferred_teacher"=>false, "user_homepage"=>"", "publisher"=>false, "kind"=>"UserData", "is_inferred_parent"=>false, "unverified_registration_date"=>"2015-03-06T03:58:14Z", "is_moderator_or_developer"=>false, "last_activity"=>"2015-03-09T00:36:44Z", "is_phantom"=>false, "proficient_exercises"=>[], "curator"=>false, "restricted_domain"=>nil, "gae_bingo_identity"=>"_gae_bingo_random:S1vGRaGGkxHpMa3lGKDfvnAw_hupNx1ory6zVzJQ", "homepage_url"=>"/", "classroom_user_status"=>0, "NOT_CLASSROOM_USER"=>0, "featured_scratchpads"=>[], "userprogresscache_version"=>76, "kaid"=>"kaid_958033363081786127610641", "badge_counts"=>{"0"=>8, "1"=>2, "2"=>0, "3"=>0, "4"=>0, "5"=>0}
    }
  }
}

def go_
  url_stub = "/topictree"
  user = User.first
  req = user.oauth_request(@auth_hash, url_stub)
  body = JSON::parse(req.body)
  body["children"].each do |subject|
    p subject["title"]
  end
end

# .each { |e| p e["title"] } ; 1
# v["children"][1]["children"][0]["children"][0]["children"][0]["children"][0]["description"]
