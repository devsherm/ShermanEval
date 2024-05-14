module Ui::BadgeHelper
    def render_badge(label = "", data: "", text: "", variant: :default, **options)
      badge_classes = " inline-flex items-center rounded-full px-2.5 py-0.5 text-xs font-semibold transition-colors focus:outline-none focus:ring-2 focus:ring-ring focus:ring-offset-2  "
      variant_classes = case variant.to_sym
      when :default
       UiHelper::PRIMARY_CLASSES
      when :secondary
        UiHelper::SECONDARY_CLASSES
      when :error, :danger, :alert, :destructive
        UiHelper::DESTRUCTIVE_CLASSES
      when :outline
        UiHelper::OUTLINE_CLASSES
      when :ghost
        UiHelper::GHOST_CLASSES
      when :success
        UiHelper::SUCCESS_CLASSES
      end
      badge_classes << " #{variant_classes}"
      text = label if label.present?
  
      content_tag :div, class: badge_classes do
        text
      end
    end
end