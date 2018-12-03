class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        # assign_sectors_to_user(params, @user.id)

        format.html {redirect_to users_url}
        format.json {render :show, status: :created, location: @user}
      else
        format.html {render :new}
        format.json {render json: @user.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)

        # assign_sectors_to_user(params, params[:id])

        format.html {redirect_to users_url}
        format.json {render :show, status: :ok, location: @user}
      else
        format.html {render :edit}
        format.json {render json: @user.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html {redirect_to users_url}
      format.json {head :no_content}
    end
  end

  private

  def assign_sectors_to_user(params, user_id)

    sectors = [params[:sector]] + params[:subsectors]['ids'].reject(&:blank?)

    # clear sectors<->users records
    User.find(user_id).sectors_users.destroy_all

    # assign users<->sectors relationships
    sectors.each do |sector_id|
      User.find(user_id).sectors_users.create!(sector_id: sector_id)
    end

  end

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
   # params.fetch(:user, {}).permit(:name, :role, sectors_users_attributes: [:sector_ids])
    params.fetch(:user, {}).permit!
  end
end
