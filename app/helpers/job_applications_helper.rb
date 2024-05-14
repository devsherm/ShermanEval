module JobApplicationsHelper
    def sort_link(status: nil, column:, label:)
        if column == params[:column]
          link_to(label, job_applications_path(status: status, column: column, direction: next_direction))
        else
          link_to(label, job_applications_path(status: status, column: column, direction: 'asc'))
        end
    end

    def filter_link(status:, label:, active: nil)
        classes = "inline-flex items-center justify-center whitespace-nowrap rounded-sm px-3 py-1.5 text-sm font-medium ring-offset-background transition-all focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50"
        classes += " bg-background text-foreground shadow-sm" if active
        link_to(label, job_applications_path(status: status), class: classes)
    end
    
    def next_direction
        params[:direction] == 'asc' ? 'desc' : 'asc'
    end

    def sort_indicator(active: nil)
        size = "w-4 h-4"
        visibility = active ? 'visible' : 'invisible'
        if params[:direction] == 'asc'
            tag.svg(xmlns: "http://www.w3.org/2000/svg", fill: "none", viewBox: "0 0 24 24", stroke_width: "1.5", stroke: "currentColor", class: "#{size} #{visibility}") do
                tag.path(stroke_linecap: "round", stroke_linejoin: "round", d: "M15.75 17.25 12 21m0 0-3.75-3.75M12 21V3")
            end
        else
            tag.svg(xmlns: "http://www.w3.org/2000/svg", fill: "none", viewBox: "0 0 24 24", stroke_width: "1.5", stroke: "currentColor", class: "#{size} #{visibility}") do
                tag.path(stroke_linecap: "round", stroke_linejoin: "round", d: "M8.25 6.75 12 3m0 0 3.75 3.75M12 3v18")
            end
        end
    end

end
