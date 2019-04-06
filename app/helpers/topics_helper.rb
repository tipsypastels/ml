module TopicsHelper
  # TODO make this settable in some way, idk, discuss
  COLOR_CLASSES = %w|
    primary link info danger
  |

  def color_for(topic)
    srand(topic.id)
    COLOR_CLASSES.sample
  end
end
