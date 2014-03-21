class FeaturesController < ApplicationController
  def index
    @features = Feature.page(params[:page]).per(6)
  end
end
