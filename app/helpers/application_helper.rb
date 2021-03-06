require 'presenter_coordinator'

module ApplicationHelper
  def display_base_errors resource
    return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end
  
  def present(object)
    presenter = Pf::PresenterCoordinator.present(object)
    yield presenter if block_given?
    presenter
  end

  def admin?
    controller.class.name.split("::").first.start_with?("Admin")
  end
end
