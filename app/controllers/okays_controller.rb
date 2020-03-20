class OkaysController < ApplicationController
  def index
    @okays = Okay.all.order({ :created_at => :desc })

    render({ :template => "okays/index.html.erb" })
  end

  def show
    the_id = params.fetch("id_from_path")
    @okay = Okay.where({:id => the_id }).at(0)

    render({ :template => "okays/show.html.erb" })
  end

  def create
    @okay = Okay.new
    @okay.owner_id = session.fetch(:user_id)
    @okay.okay_or_not = params.fetch("okay_or_not_from_query", false)

    if @okay.valid?
      @okay.save
      
      # Create a new instance of the Mailgun client
          mg_api_key = ENV.fetch("MAILGUN_TOKEN")
          mg_client = Mailgun::Client.new(mg_api_key)
      # Define your message parameters
        message_params =  {
          :from => "postmaster@mg.amiokay.org",
          :to => "briankhorshad@GMAIL.COM",
          :subject => "Hello!",
          :text => "Just testing out this mailgun app!"
        }
      # Send your message through the client
        mg_client.send_message("https://3000-a974ace8-629c-4987-a1f3-567e66652a09.ws-us02.gitpod.io/", message_params)

      redirect_to("/okays", { :notice => "Okay created successfully." })
    else
      redirect_to("/okays", { :notice => "Okay failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("id_from_path")
    @okay = Okay.where({ :id => the_id }).at(0)

    @okay.owner_id = params.fetch("owner_id_from_query")
    @okay.okay_or_not = params.fetch("okay_or_not_from_query", false)

    if @okay.valid?
      @okay.save
      redirect_to("/okays/#{@okay.id}", { :notice => "Okay updated successfully."} )
    else
      redirect_to("/okays/#{@okay.id}", { :alert => "Okay failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("id_from_path")
    @okay = Okay.where({ :id => the_id }).at(0)

    @okay.destroy

    redirect_to("/okays", { :notice => "Okay deleted successfully."} )
  end

end
