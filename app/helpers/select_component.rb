class SelectComponent
    include UiHelper
    attr_reader :name, :selected, :view_context, :collection
  
    def initialize(name:, view_context:, selected: nil, prompt: "Select", collection: [], required: false, **options, &block)
      @name = name
      @view_context = view_context
      @selected = selected
      @prompt = prompt
      @collection = collection
      @required = required
      @options = options
      @content = view_context.capture(self, &block) if block
    end
  
    def call
      prompt_option = view_context.content_tag(:option, @prompt, value: "", class: "text-muted-foreground") unless @prompt.nil?
      view_context.content_tag :select, prompt_option + collection_options, name: name, class: tw("rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background pr-8 placeholder:text-muted-foreground focus:outline-none focus:ring-2 focus:ring-ring focus:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50", @options[:class]), required: @required
    end
  
    private

    def collection_options
      @collection.map do |item|
        option_options = {value: item}
        option_options[:selected] = "selected" if option_options[:value] == @selected
        view_context.content_tag :option, item, option_options
      end.join.html_safe
    end

end
