class ExampleMailer < ApplicationMailer
  default from: "saichetanreddy0211@gmail.com"
    def welcome_user(user)
        @user_name = user
        mail(to: "mypersonalacc0211@gmail.com", subject: 'Welcome to My Awesome Site')
    end
end