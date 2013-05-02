class ReviewsController < ApplicationController
  load_and_authorize_resource :submission
  load_and_authorize_resource :review, through: :submission, except: :create

  def create
    @review = Review.new(params[:review])
    @review.user = current_user
    @review.submission = @submission
    respond_to do |format|
      if @review.save
        format.html { redirect_to @submission, notice: 'Review was successfully created.' }
        format.json { render json: @submission, status: :created, location: @submission }
      else
        flash[:error] = 'Review not saved.'
        format.html { render 'submissions/show' }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reviews/1
  # PUT /reviews/1.json
  def update
    respond_to do |format|
      if @review.update_attributes(params[:review])
        format.html { redirect_to @submission, notice: 'Review was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render "submissions/show" }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review.destroy

    respond_to do |format|
      format.html { redirect_to @submission }
      format.json { head :no_content }
    end
  end
end
