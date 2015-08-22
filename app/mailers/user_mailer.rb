class UserMailer < ApplicationMailer
  def tour_started(tour, user)
    @tour = tour

    mail to: user.email
  end

  def tour_finished(tour, user)
    @tour = tour

    mail to: user.email
  end
end
