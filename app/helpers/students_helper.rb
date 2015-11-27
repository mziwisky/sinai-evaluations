module StudentsHelper
  def form_string_row(label, content, hint=nil)
    html = [
      '<li class="string input required stringish"><label class="label">',
      html_escape(label),
      '</label><span>',
      html_escape(content),
      '</span></li>'
    ]
    html.join.html_safe
  end
end
