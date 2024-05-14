require "tailwind_merge"

module UiHelper
  def tw(*classes)
    TailwindMerge::Merger.new.merge(classes.join(" "))
  end

  PRIMARY_CLASSES = " bg-primary text-primary-foreground hover:bg-primary/80 "
  SECONDARY_CLASSES = " bg-secondary text-secondary-foreground hover:bg-secondary/80 "
  OUTLINE_CLASSES = "  border border-input bg-background hover:bg-accent hover:text-accent-foreground "
  GHOST_CLASSES = " hover:bg-accent hover:text-accent-foreground  "
  DESTRUCTIVE_CLASSES = " bg-destructive text-destructive-foreground hover:bg-destructive/90 "
  SUCCESS_CLASSES = "border-green-500  border hover:bg-green/80 "

  module Button
    PRIMARY = UiHelper::PRIMARY_CLASSES
    SECONDARY = UiHelper::SECONDARY_CLASSES
    OUTLINE = UiHelper::OUTLINE_CLASSES
    GHOST = UiHelper::GHOST_CLASSES
    DESTRUCTIVE = UiHelper::DESTRUCTIVE_CLASSES
    SUCCESS = UiHelper::SUCCESS_CLASSES
  end

  module Alert
  end
end
