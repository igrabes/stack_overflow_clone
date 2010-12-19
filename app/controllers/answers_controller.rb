class AnswersController < ApplicationController
  # GET /answers
  # GET /answers.xml
  before_filter :require_user, :only => [:new, :create, :edit, :update, :destroy]
  before_filter :get_question, :only => [:new, :create, :edit, :update, :show, :destroy, :index]

  def index
    @question.views += 1
    @question.save
    if params[:question_id]
      @answers = Answer.find_all_by_question_id params[:question_id]
    else
      @answers = Answer.all
    end

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /answers/1
  # GET /answers/1.xml
  def show
    @answer = Answer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /answers/new
  # GET /answers/new.xml
  def new
    @answer = Answer.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @answer }
    end
  end

  # GET /answers/1/edit
  def edit
    @answer = Answer.find(params[:id])
    verify_user(@answer)
  end

  # POST /answers
  # POST /answers.xml
  def create
    @answer = Answer.new(params[:answer])
    @answer.user = current_user
    @answer.question = @question

    verify_user(@answer)

    respond_to do |format|
      if @answer.save
        format.html { redirect_to(question_answers_url(@question), :notice => 'Answer was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /answers/1
  # PUT /answers/1.xml
  def update
    @answer = Answer.find(params[:id])

    respond_to do |format|
      if @answer.update_attributes(params[:answer])
        format.html { redirect_to([@question, @answer], :notice => 'Answer was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /answers/1
  # DELETE /answers/1.xml
  def destroy
    @answer = Answer.find(params[:id])

    verify_user(@answer)
    @answer.destroy

    respond_to do |format|
      format.html { redirect_to(question_answers_url(@question)) }
    end
  end

  private

  def verify_user(answer)
    unless current_user == answer.user
      flash[:notice] = "You must be the creator of this answer to edit it"
      redirect_to :action => :show
      return
    end
  end

  def get_question
    @question = Question.find params[:question_id]
  end


end
