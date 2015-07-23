class MembersController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :set_member, only: [:show, :edit, :update, :destroy]

  # get user info from ajax
  def memberinfo
    puts "reached memberinfo"
    puts params[:customer_email]
    puts params[:customer_id]

    #render :json => {'member_email_result' => 'success'}
    if params[:customer_email].present?
      if Member.exists?(:member_id => params[:customer_id])
        puts "came in exist"
        @members = Member.find_by(:member_id =>params[:customer_id])
        puts "after find"
        #render action: "index"

      else
        puts "came in not exist"
        @member = Member.create(:member_id =>params[:customer_id], :email => params[:customer_email])
        @members = Member.find_by(:member_id =>params[:customer_id])

        #render action: "index"
      #redirect_to :action => "index", :customer_email => params[:customer_email], :customer_id => params[:customer_id]
      end
      
      puts "after member exist if else"
    end

    puts "after param exist if else"
  end

  # GET /members
  # GET /members.json
  def index
    puts "come in index"
    @members = Member.all
    puts "come out from index"
  end

  # GET /members/1
  # GET /members/1.json
  def show
  end

  # GET /members/new
  def new
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
