module Ui::FormsHelper
  def render_form_with(model:, url:, **opts)
    form_with(model: model, url: url, **opts.merge(builder: FormBuilder)) do |form|
      yield form
    end
  end

  def render_form_for(obj, **opts)
    form_for(obj, **opts.merge(builder: FormBuilder), html: opts) do |form|
      yield form
    end
  end
end