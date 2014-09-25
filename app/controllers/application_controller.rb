class ApplicationController < ActionController::Base
  def page
    params[:page] || 1
  end

  def per_page
    params[:per_page] || 5
  end
end
