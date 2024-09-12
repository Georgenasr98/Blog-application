class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  # skip_before_action :authenticate_request, only: [:login, :create]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end
  # post /login
  def login
    @user = User.find_by(email: params[:email])

    if @user && @user.authenticate(params[:password])
      jwt_token = JwtService.encode(user_id: @user.id) # Example of JWT generation
      respond_to do |format|
        format.html { redirect_to user_url(@user), notice: "Logged in successfully." }
        format.json { render json: { token: jwt_token }, status: :ok }
      end
    else
      respond_to do |format|
        format.html { redirect_to login_url, alert: "Invalid email or password." }
        format.json { render json: { error: "Invalid email or password." }, status: :unprocessable_entity }
      end
    end
  end
  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    # Set the password attribute directly
    @user.password = user_params[:password]

    # Custom check for null or missing parameters
    if user_params[:name].blank? || user_params[:email].blank? || user_params[:password].blank? || user_params[:image].blank?
      @user.errors.add(:base, "All fields (name, email, password, image) must be present.")
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
      return
    end

    # Custom email format validation
    unless valid_email?(user_params[:email])
      @user.errors.add(:email, "is not a valid email address.")
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
      return
    end

    respond_to do |format|
      if @user.save
        format.html { redirect_to user_url(@user), notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Helper method to validate email format
  def valid_email?(email)
    email.match?(URI::MailTo::EMAIL_REGEXP)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name, :email, :password, :image)
  end
end
