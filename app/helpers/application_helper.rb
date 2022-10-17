module ApplicationHelper

  # Page title content
  def title(page_title)
    content_for(:title) { page_title }
  end

  def display_form_errors(obj)
    if obj.errors.any?
      content_tag :div, id: 'error_explanation' do
        concat(content_tag :h2, "#{pluralize(obj.errors.count, 'error')} reported")
        concat(
          content_tag(:ul) do
            obj.errors.full_messages.each do |msg|
              concat(content_tag :li, msg)
            end
          end
        )
      end
    end
  end

end
