module DeviseHelper
  def devise_error_messages!
    return "" if resource.errors.empty?

    html = ""
    messages = resource.errors.full_messages.each do |errmsg|
      html += <<-EOF
      <div class="alert alert-danger">
        #{errmsg}
      </div>
      EOF
    end
    raw html
  end

  def devise_error_messages?
    resource.errors.empty? ? false : true
  end
end
