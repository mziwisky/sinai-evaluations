module StudentsHelper
  def form_string_row(label, content, error=nil)
    html = [
      '<li class="string input required stringish"><label class="label">',
      html_escape(label),
      '</label><span>',
      content,
      '</span>'
    ]
    html.concat ['<p class="inline-errors">', html_escape(error), '</p>',] if error.present?
    html << '</li>'
    html.join.html_safe
  end
end
