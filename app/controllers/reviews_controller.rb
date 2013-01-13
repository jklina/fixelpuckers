class ReviewsController < ApplicationController
  # GET /reviews/new
  # GET /reviews/new.json
  # def new
  #   @submission.find(params[submission_id])
  #   @review = @submission.reviews.build

  #   respond_to do |format|
  #     format.html # new.html.erb
  #     format.json { render json: @review }
  #   end
  # end

  # GET /reviews/1/edit
  # def edit
  #   @submission.find(params[submission_id])
  #   @review = @submission.reviews.find(params[:id])
  # end

  # POST /reviews
  # POST /reviews.json
  def create
    @submission = Submission.find(params[:submission_id])
    @review = @submission.reviews.build
    @review.user = current_user

    respond_to do |format|
      if @review.save
        format.html { redirect_to @submission, notice: 'Review was successfully created.' }
        format.json { render json: @submission, status: :created, location: @submission }
      else
        format.html { render action: "new" }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reviews/1
  # PUT /reviews/1.json
  def update
    @review = Review.find(params[:id])

    respond_to do |format|
      if @review.update_attributes(params[:review])
        format.html { redirect_to @review, notice: 'Review was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
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
