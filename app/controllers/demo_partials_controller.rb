class DemoPartialsController < ApplicationController
  def new
    @zone = "Zone New Action"
    @date = Date.today
  end

  def edit
    @zone = "Zone Edit Action"
    @date = Date.today - 4
  end
end
