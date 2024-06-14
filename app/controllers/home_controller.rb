class HomeController < ApplicationController
  def index
    ExampleJob.set(wait: 20.seconds).perform_later('Alice', 5)
  end
end
