task "update_user_harvest_data" => :environment do

  User.all.each do |user|
    HarvestSeeder.seed(user)
  end

end
