class FieldOwnerMailer < ApplicationMailer
  default from: 'develop_rails_4fun@zoho.com'
 
  def welcome_field_owner(field_owner)
    @field_owner = field_owner
    @url  = 'localhost:3000'
    subject = "Welcome #{@field_owner.full_name}"

    mail(to: @field_owner.email, subject: "Welcome to my site")
  end
end
