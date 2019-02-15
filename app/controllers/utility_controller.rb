class UtilityController < ApplicationController

  def toggle
    respond_with_text do
      if token_user.present?
        ButtonHandler.handle(params[:button], token_user)
      else
        "invalid"
      end
    end
  end

  def running_timer
    respond_with_text do
      if token_user.present?
        RunningTimer.find(token_user)
      else
        "invalid"
      end
    end
  end

  def identify
    user = User.find_by(device_id: params[:device_id])
    render text: user.try(:token) || "nothing"
  end

  private

  def respond_with_text
    body = yield

    render text: body
  end

  def token_user
    User.find_by(token: params[:token])
  end

end
