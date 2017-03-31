class PlayerMailer < ApplicationMailer
  default from: 'develop_rails_4fun@zoho.com'

  def welcome_player (player)
    @player = player
    @url  = 'https://soccerchallenge.herokuapp.com'
    subject = "Welcome #{@player.full_name}"

    mail(to: @player.email, subject: subject)
  end

end
