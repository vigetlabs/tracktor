class UtilityController < ApplicationController

  def toggle
    respond_with_json do
      if token_user.present?
        ButtonHandler.handle(params[:button], token_user)
      else
        { :invalid_user => true }
      end
    end
  end

  def running_timer
    respond_with_json do
      if token_user.present?
        RunningTimer.find(token_user)
      else
        { :invalid_user => true }.to_json
      end
    end
  end

  private

  def respond_with_json
    body = yield

    render :json => body
  end

  def token_user
    User.find_by(token: params[:token])
  end

end
