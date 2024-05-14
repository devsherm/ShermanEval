module Ui::AlertHelper
    def render_alert(title: nil, description: nil, variant: :default, icon: true, **options, &block)
      alert_classes = case variant.to_sym
      when :default
        "[&>svg]:text-foreground bg-background text-foreground"
      when :error, :danger, :alert, :destructive
        "border-destructive/50 text-destructive dark:border-destructive [&>svg]:text-destructive"
      when :success
        "border-success/50 text-success dark:border-success [&>svg]:text-success"
      when :info
        "border-info/50 text-info dark:border-info [&>svg]:text-info"
      when :attention
        "border-attention/50 text-attention dark:border-attention [&>svg]:text-attention"
      end
      alert_classes = tw(alert_classes, options[:class])
      content = (capture(&block) if block) || description
      render "ui/alert", title:, content:, alert_classes:, variant:, icon:
    end
  end