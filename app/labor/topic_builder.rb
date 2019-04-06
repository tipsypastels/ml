class TopicBuilder
  attr_reader :topic, :post

  def initialize(params, author)
    content = params.delete(:content)
    @topic = Topic.new(params)
    @topic.user = author
    @topic.tag_list = TagPreprocessor.preprocess(@topic.tag_list)

    @post = Post.new(content: content)
    @post.topic = @topic
    @post.user = author
  end

  def save
    @topic.save && @post.save
  end
end