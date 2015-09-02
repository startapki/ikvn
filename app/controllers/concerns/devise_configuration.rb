module DeviseConfiguration
  extend ActiveSupport::Concern

  private

  def additional_devise_permitted_params
    {}
  end

  def configure_permitted_parameters
    additional_devise_permitted_params.each do |(method, fields)|
      fields.each do |field|
        devise_parameter_sanitizer.for(method) << field
      end
    end
  end
end
