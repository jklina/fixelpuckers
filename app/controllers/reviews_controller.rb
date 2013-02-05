class ReviewsController < ApplicationController
  def create
    @submission = Submission.find(params[:submission_id])
    @review = @submission.reviews.build(params[:review])
    @review.user = current_user

    respond_to do |format|
      if @review.save
        format.html { redirect_to @submission, notice: 'Review was successfully created.' }
        format.json { render json: @submission, status: :created, location: @submission }
      else
        flash[:error] = 'Review not saved.'
        format.html { render template: 'submissions/show' }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reviews/1
  # PUT /reviews/1.json
  def update
    @submission = Submission.find(params[:submission_id])
    @review = @submission.reviews.find(params[:id])

    respond_to do |format|
      if @review.update_attributes(params[:review])
        format.html { redirect_to @submission, notice: 'Review was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render template: "submissions/show" }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review = Review.find(params[:id])
    @review.destroy

    respond_to do |format|
      format.html { redirect_to reviews_url }
      format.json { head :no_content }
    end
  end
end
