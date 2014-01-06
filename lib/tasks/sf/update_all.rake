namespace :sf do
  task update_all: :environment do
    Time.zone = "Pacific Time (US & Canada)"

    User.all.each do |user|
      SfSyncher.(user)
    end
  end
end
