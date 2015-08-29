class UserDecorator < Draper::Decorator
  delegate_all

  def role
    h.content_tag(:div, class: 'btn-group', role: 'group') do
      User.roles.keys.each do |role|
        h.concat role_button(role, role == source.role)
      end
    end
  end

  private

  def role_button(role, active)
    h.form_for(source, html: { class: 'role-button' }) do |f|
      h.concat f.hidden_field(:id)
      h.concat f.hidden_field(:role, value: role)
      h.concat f.submit(h.t("user.roles.#{role}"),
                        class: "btn btn-primary #{'active' if active}",
                        disabled: source == h.current_user)
    end
  end
end
