module ApplicationHelper

  def hello_world(value,type)
    if value.eql?("noob")
      content_tag(:span,value,:class=>"badge badge-dark badge-pill")
    else
      content_tag(:span,value,:class=>"badge badge-#{type} badge-pill")
    end
  end
end
