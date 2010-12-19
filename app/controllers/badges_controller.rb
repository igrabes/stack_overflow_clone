class BadgesController < ApplicationController

  def index
    User.all.each do |u|
      Badge.apply(u)
    end
    @counts = Badge.name_counts #Badge.count(:all, :group => 'name')
  end


end
