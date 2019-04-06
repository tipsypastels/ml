class TagPreprocessor
  def self.preprocess(tag_list)
    new(tag_list).preprocess
  end

  def initialize(tag_list)
    @tag_list = tag_list
  end
  
  def preprocess
    return if @tag_list.blank?
    @tag_list.map { |tag|
      tag.gsub!(/[^0-9A-Za-z]/, '')
      tag.presence
    }.compact
  end
end