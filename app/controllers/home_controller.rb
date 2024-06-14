class HomeController < ApplicationController
  def index
    # ExampleJob.set(wait: 20.seconds).perform_later('Alice', 5)
    ExampleMailer.welcome_user("Sai Chetan").deliver_now
  end
end
