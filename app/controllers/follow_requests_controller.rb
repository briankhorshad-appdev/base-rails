class FollowRequestsController < ApplicationController
  def index
    @follow_requests = FollowRequest.all.order({ :created_at => :desc })

    render({ :template => "follow_requests/index.html.erb" })
  end

  def show
    the_id = params.fetch("id_from_path")
    @follow_request = FollowRequest.where({:id => the_id }).at(0)

    render({ :template => "follow_requests/show.html.erb" })
  end

  def create
    @follow_request = FollowRequest.new
    @follow_request.sender_id = session.fetch(:user_id)
    @follow_request.recipient_id = params.fetch("recipient_id_from_query")

    if @follow_request.valid?
      @follow_request.save
      redirect_to("/users", { :notice => "Follow request created successfully." })
    else
      redirect_to("/users", { :notice => "Follow request failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("id_from_path")
    @follow_request = FollowRequest.where({ :id => the_id }).at(0)

    @follow_request.sender_id = params.fetch("sender_id_from_query")
    @follow_request.recipient_id = params.fetch("recipient_id_from_query")
    

    if @follow_request.valid?
      @follow_request.save
      redirect_to("/follow_requests/#{@follow_request.id}", { :notice => "Follow request updated successfully."} )
    else
      redirect_to("/follow_requests/#{@follow_request.id}", { :alert => "Follow request failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("id_from_path")
    @follow_request = FollowRequest.where({ :id => the_id }).at(0)

    @follow_request.destroy

    redirect_to("/users", { :notice => "Follow request deleted successfully."} )
  end

  def show_my_followers
    the_user_id = session.fetch(:user_id)

    @follow_request = FollowRequest.where({ :recipient_id => the_user_id })
    render({ :template => "/follow_requests/users_requests.html.erb"})

    #render( { :plain => "Yeah! You did it buddy! You made this page work!"})
  end 

  def show_people_i_follow
    the_user_id = session.fetch(:user_id)

    @follow_request = FollowRequest.where({ :sender_id => the_user_id })

    render( { :template => "/follow_requests/users_follows.html.erb"})
  end 
end
