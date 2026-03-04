class SessionsController < ApplicationController
  def new
  end

  def destroy
      session["user_id"] = nil
      flash["notice"] = "Logged Out"
      redirect_to "/login"
  end
  
  def create
    require "bcrypt"

    user = User.find_by({"email" => params["email"]})

    if user == nil 
      flash["notice"] = "Nope."
      redirect_to "/login"
    else
      if BCrypt::Password.new(user["password"]) == params["password"]
        session["user_id"] = user["id"]
        flash["notice"] = "Sucessful Login"
        redirect_to "/posts"
      else
        flash["notice"] = "Incorrect password."
        redirect_to "/login"
      
      end
    end
  end
end
