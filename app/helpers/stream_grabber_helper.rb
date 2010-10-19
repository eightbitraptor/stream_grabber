module StreamGrabberHelper
  def generate_stream_list
    data = StreamGrabber.grab(5).inject([]){ |memo,acc| memo << content_tag(:li,raw(acc[1])) }
    content_tag :ul, :class => "activity-stream" do
      data.join("\n")
    end
  end
end