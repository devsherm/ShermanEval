module Ui::CheckboxHelper
    def render_checkbox(label:, name:, **options)
      render "ui/checkbox", name: name, label: label, options: options
    end
end