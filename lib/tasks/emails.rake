namespace :email do
  desc 'Notify participiants that tour is started'
  task tour_started: :environment do
    now = Time.zone.now
    Tour.where(started_at: (now.beginning_of_hour..now.end_of_hour)).find_each do |tour|
      tour.season.participations.wants_email(User.roles[:user]).find_each do |participiant|
        UserMailer.tour_started(tour, participiant.user).deliver_now
      end
    end
  end

  desc 'Notify judges that tour is finished'
  task tour_finished: :environment do
    now = Time.zone.now
    Tour.where(finished_at: (now.beginning_of_hour..now.end_of_hour)).find_each do |tour|
      tour.season.participations.wants_email(User.roles[:judge]).find_each do |participiant|
        UserMailer.tour_finished(tour, participiant.user).deliver_now
      end
    end
  end
end
