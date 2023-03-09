class UsersController < ApplicationController
  def index
    matching_users = User.all

    @list_of_users = matching_users.order({ :username => :asc })

    render({ :template => "users/index.html.erb" })
  end

  def show_profile
    the_id = params.fetch("path_id")

    matching_users = User.where({ :id => the_id })

    @the_user = matching_users.at(0)

    if @the_user.private?
      follow_requests = @the_user.received_follow_requests
      matching_requests = follow_requests.where({ :sender_id => session.fetch(:user_id) })
      the_request = matching_requests.at(0)

      if the_request.present?
        if the_request.status == "approved"
          render({ :template => "users/show.html.erb" })
        else
          redirect_to("/", { :alert => "You're not authorized for that." })
        end
      else
        redirect_to("/", { :alert => "You're not authorized for that." })
      end
    else # if user not private
      render({ :template => "users/show.html.erb" })
    end
  end
end
