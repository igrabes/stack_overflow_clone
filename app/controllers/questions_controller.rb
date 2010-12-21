class QuestionsController < ApplicationController
  # GET /questions
  # GET /questions.xml
  before_filter :require_user, :only => [:new, :create, :edit, :update, :destroy]

  def index
    params[:sorted_by] ||= "newest"
    @sorted_by = params[:sorted_by]

    @questions = Question.filter(params);

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @questions }
    end
  end

  # GET /questions/1
  # GET /questions/1.xml
  def show
    @question = Question.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @question }
    end
  end

  # GET /questions/new
  # GET /questions/new.xml
  def new
    @question = Question.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @question }
    end
  end

  # GET /questions/1/edit
  def edit
    @question = Question.find(params[:id])
    verify_user(@question)
  end

  # POST /questions
  # POST /questions.xml
  def create
    @question = Question.new(params[:question])
    @question.user = current_user
    @question.update_active_at

    respond_to do |format|
      if @question.save
        format.html { redirect_to(question_answers_path(@question), :notice => 'Question was successfully created.') }
        format.xml  { render :xml => @question, :status => :created, :location => @question }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @question.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /questions/1
  # PUT /questions/1.xml
  def update
    @question = Question.find(params[:id])
    verify_user(@question)
    @question.update_active_at

    respond_to do |format|
      if @question.update_attributes(params[:question])
        format.html { redirect_to(question_answers_path(@question), :notice => 'Question was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @question.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.xml
  def destroy
    @question = Question.find(params[:id])
    verify_user(@question)

    @question.destroy

    respond_to do |format|
      format.html { redirect_to(questions_url) }
      format.xml  { head :ok }
    end
  end

  def tags
    @tags = Question.tag_counts_on(:tags)
  end

  private
  
  def verify_user(question)
    unless current_user == question.user
      flash[:notice] = "You must be the creator of this question to edit it"
      redirect_to :action => :show
      return false
    end
  end

end
