task "update_user_tokens" => :environment do

  User.all.each do |user|
    user.update_token
  end

end
