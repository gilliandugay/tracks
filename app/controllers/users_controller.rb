class UsersController < Clearance::UsersController
  def create
    @user = User.new params[:user]
    if @user.save
      sign_in @user
      render :json => @user
    else
      render :json => errors_hash
    end
  end

  def update
    @user = User.find params[:id]
    if @user.update_attributes(params[:user])
      render :json => @user
    else
      render :json => errors_hash
    end
  end

  def fetch
    render :json => User.find(params[:id])
  end

  private

  def errors_hash
    { :errors => @user.errors.merge(:fields => @user.errors.keys) }
  end
end