class BreadcrumbsBuilder < BreadcrumbsOnRails::Breadcrumbs::Builder
  def render
    @context.content_tag(:ul, class: 'nav navbar-nav') do
      @elements.map.with_index do |element, index|
        render_element(element, active: index == @elements.length - 1)
      end.join.html_safe
    end
  end

  def render_element(element, active: false)
    @context.content_tag(:li, class: ('active' if active)) do
      @context.link_to(compute_name(element),
                       compute_path(element),
                       element.options)
    end
  end
end
