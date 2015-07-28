class MembersController < ApplicationController
  # skip_before_filter is to escape authenticity_token check for ajax call
  skip_before_filter :verify_authenticity_token
  before_action :set_member, only: [:show, :edit, :update, :destroy]

  @@ajaxRendered = false
  puts "before memberinfo method : #{@@ajaxRendered}"
  # get member info from ajax
  def memberinfo
    if @@ajaxRendered == false
      puts "reached memberinfo #{params[:customer_email]} #{params[:customer_id]}"

      if params[:customer_email].present?
        if Member.exists?(:member_id => params[:customer_id])
          # if member already been created, just redirect to index and render him out
          puts "in member exist"

          session[:current_member_id] = params[:customer_id]

          redirect_to :action => "index", :customer_id => params[:customer_id], :customer_email => params[:customer_email] and return
        else
          # create member automatically when he logs in, insert 2 params first
          puts "in member not exist"

          #@member = Member.create(:member_id =>params[:customer_id], :email => params[:customer_email])

          session[:current_member_id] = params[:customer_id]

          redirect_to :action => "index", :customer_id => params[:customer_id], :customer_email => params[:customer_email] and return
        end
      end
      @@ajaxRendered = true
      # render json reponse to ajax
    else
      puts "ajax already rendered #{@@ajaxRendered}"
    end
    render :json => {'member_email_result' => 'success'}
  end

  # GET /members
  # GET /members.json
  def index
    puts "hello i am in index"
    # debug - can i know which controller action it came from?
    # if i know it is from edit, then i can use session to check.
    # if it is not from edit, then i can use customer_id.blank? to render empty

    # receive param from memberinfo redirect, then render user
    member_id = params[:customer_id]
    member_email = params[:customer_email]

    puts "index customer_id #{member_id} customer email #{member_email}"
    puts "index session #{session[:current_member_id]}"

    # params from edit
    action_origin = params[:fromOrigin]
    puts "action origin = #{action_origin}"

    # if customer_id empty means either user is log out OR from 'edit' redirect
    # if customer_id empty, check whether session empty | for 'edit'
    # debug - if customer_id.blank && not from edit, empty session
    if member_id.blank?
      puts "member_id empty"
      if action_origin.blank?
        puts "render empty template"
        reset_session
        puts "removed session = #{session[:current_member_id]}"
        render :template => "members/login"
        # # if session empty means there's no input from ajax | user not login
        # if session[:current_member_id].blank?
        #   puts "session empty"
        #   # user not log in so render ask user login page
        #   render :template => "members/login"
      else
        puts "session exist"
        puts "session exist = #{action_origin}"
        # session not empty means input from ajax | user is logged in
        # if user logged in, get session of the user and load his details
        # session not empty is also used when user navigate back from other action
        @members = Member.where(:member_id => session[:current_member_id])
      end
    else
      puts "customer_id not empty"
      # user first log in
      @members = Member.where(:member_id => member_id)
      if @members.blank?
        # record not found, is new member. Show prompt ask them create profile.
        render :template => "members/prompt", :locals => {:member_id => member_id, :member_email => member_email}
      end
    end

    puts "come out from index"
  end

  # GET /members/1
  # GET /members/1.json
  def show
    redirect_to :action => "index"
  end

  # GET /members/new
  def new
    # params from create link_to
    @member_id = params[:member_id]
    @member_email = params[:member_email]
    puts "new #{@member_id} #{@member_email}"
    @member = Member.new
  end

  # GET /members/1/edit
  def edit
  end

  # POST /members
  # POST /members.json
  def create
    @member = Member.new(member_params)

    respond_to do |format|
      if @member.save
        format.html { redirect_to @member, notice: 'Member was successfully created.' }
        format.json { render :show, status: :created, location: @member }
      else
        format.html { render :new }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /members/1
  # PATCH/PUT /members/1.json
  def update
    respond_to do |format|
      if @member.update(member_params)
        format.html { redirect_to @member, notice: 'Member was successfully updated.' }
        format.json { render :show, status: :ok, location: @member }
      else
        format.html { render :edit }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1
  # DELETE /members/1.json
  def destroy
    @member.destroy
    respond_to do |format|
      format.html { redirect_to members_url, notice: 'Member was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = Member.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def member_params
      params.require(:member).permit(:member_id, :email, :bday, :occupation, :profilepic)
    end
end
