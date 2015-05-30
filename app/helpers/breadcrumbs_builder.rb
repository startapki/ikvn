# The BootstrapBreadcrumbsBuilder is a Bootstrap compatible breadcrumb builder.
# It provides basic functionalities to render a breadcrumb navigation according to Bootstrap's conventions.
#
# BootstrapBreadcrumbsBuilder accepts a limited set of options:
# * separator: what should be displayed as a separator between elements
#
# You can use it with the :builder option on render_breadcrumbs:
#     <%= render_breadcrumbs :builder => ::BootstrapBreadcrumbsBuilder, :separator => "&raquo;" %>
#
# Note: You may need to adjust the autoload_paths in your config/application.rb file for rails to load this class:
#     config.autoload_paths += Dir["#{config.root}/lib/"]
#
class BreadcrumbsBuilder < BreadcrumbsOnRails::Breadcrumbs::Builder
  def render
    @context.content_tag(:ul, class: 'nav navbar-nav') do
      @elements.map.with_index do |element, index|
        render_element(element, active: index == @elements.length - 1)
      end.join.html_safe
    end
  end

  def render_element(element, active: false)
    current = @context.current_page?(compute_path(element))

    @context.content_tag(:li, class: ('active' if active)) do
      @context.link_to(compute_name(element),
                       compute_path(element),
                       element.options)
    end
  end
end
