module ApplicationHelper

  # Page title content
  def title(page_title)
    content_for(:title) { page_title }
  end

  def display_form_errors(obj)
    if obj.errors.any?
      haml_tag '#error_explanation' do
        haml_tag :h2, "#{pluralize(obj.errors.count, 'error')} reported"
        haml_tag :ul do
          obj.errors.full_messages.each do |msg|
            haml_tag :li, msg
          end
        end
      end
    end
  end

end
