module ApplicationHelper
  def actions_for(item, options = {})
    wrapper_options = options.merge({
      class: "actions btn-group group #{options[:class]}"
    })

    content_tag(:div, wrapper_options) do
      if can? :update, item
        item_name = Draper.undecorate(item).class.to_s.underscore
        concat link_to('', send(:"edit_#{item_name}_path", item),
                       class: 'btn btn-default btn-xs glyphicon glyphicon-pencil')
      end

      if can? :destroy, item
        concat link_to('', item, method: :delete,
                       class: 'btn btn-danger btn-xs glyphicon glyphicon-remove',
                       data: { confirm: t('question.are_you_sure') })
      end
    end
  end

  def icon(name)
    content_tag(:i, '', class: "glyphicon glyphicon-#{name}")
  end
end
