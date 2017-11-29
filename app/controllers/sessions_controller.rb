class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # need to fix password required issue to enable this
      #user.signed_in_at = DateTime.now
      #user.save!(touch: false)
      user.touch(:signed_in_at)
      sign_in user
      flash[:success] = 'You have successfully signed in'
      redirect_to overview_user_path(session[:user_username])
    else
      flash.now[:danger] = 'Yo ass goofed hommie! Da email/password you provided is invalid!'
      render 'new'
    end
  end

  def destroy
    user = User.find(session[:user_id])
    sign_out
    flash[:success] = 'You have successfully signed out'
    redirect_to root_url
  end
end
