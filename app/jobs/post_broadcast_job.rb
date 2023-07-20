class PostBroadcastJob < ApplicationJob
  queue_as :default

  def perform(post)
    # Do something later
    serialized_data = ActiveModelSerializers::SerializableResource.new(post, { serializer: PostSerializer })
    ActionCable.server.broadcast('posts_channel', {
      type: 'post_created',
      payload: {
        post: serialized_data
      }
    })

    puts "PostBroadcastJob is working #{serialized_data}"
  end
end