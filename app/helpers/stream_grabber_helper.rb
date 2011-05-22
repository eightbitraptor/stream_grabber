module StreamGrabberHelper
  def generate_stream_list(num=15, *args)
    if args.present?
      css_class = args.first[:class]
      css_id = args.first[:id]
    end

    data = StreamGrabber.grab(num).inject([]){ |memo,acc| memo << content_tag(:li,raw(acc[1])) }

    content_tag :ol, {:class => css_class || 'activity_list', :id => css_id || 'stream_grabber'} do 
      raw(data.join("\n"))
    end
  end
end
