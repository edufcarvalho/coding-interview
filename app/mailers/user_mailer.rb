class UserMailer < ApplicationMailer
  default from: 'placeholder@email.com'

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to our site!')
  end
end
