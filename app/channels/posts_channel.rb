class PostsChannel < ApplicationCable::Channel
  def subscribed
    stop_all_streams
    stream_from "posts_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    # stop_all_streams
  end


  def receive(data)
    post = data['post'] # the post data sent from the client side (React) to the server side (Rails) via ActionCable (WebSockets) 
    # using background jobs to process the data after saving to the database (PostgreSQL) 
        
    puts "New post has been created: => #{post}"

    # PostBroadcastJob.perform_later(post) # this is the job that will be performed in the background 

  end

end
