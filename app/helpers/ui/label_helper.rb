module Ui::LabelHelper
  def render_label(name:, label:, **options)
    render "ui/label", name: name, label: label, options: options
  end
end