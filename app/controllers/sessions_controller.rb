class SessionsController < ApplicationController
  def new
    # # cookie thong thuong
    # cookies[:demo_normal] = "normal"

    # # gia tri cua cookie se~ duoc ma~ hoa'
    # # cookie nay` duoc ma~ hoa' voi' key la `secrets.secret_key_base`.
    # cookies.signed[:demo_signed] = "signed"

    # # gia tri cua cookie se~ duoc ma~ hoa' tuong tu nhu cookies.signed
    # # cookie nay` duoc ma~ hoa' voi' key la `secrets.secret_key_base`.
    # cookies.encrypted[:demo_encrypted] = "encrypted"

    # # khi dung` http only thi` cookie se~ khong the? doc duoc bang` javascript, va` cookie se~ het han sau thoi` gian duoc set
    # cookies[:demo_httponly] = {value: "http only", expires: TIme.current + 1.hour, httponly: true}

    # # khi dung` cookies.permanent thi` cookie se~ het han sau mot thoi gian dai khong 20 nam
    # cookies.permanent[:demo_permanent] = "permanent"
  end

  def create
    user = User.find_by email: params.dig(:session, :email)&.downcase
    if user.try(:authenticate, params.dig(:session, :password))
    # Log the user in and redirect to the user's show page.
      log_in user
      params.dig(:session, :remember_me) == "1" ? remember(user) : forget(user)
      redirect_back_or user
    else
    # Create an error message.
    flash.now[:danger] = t "invalid_email_password_combination"
    render :new
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end
end
