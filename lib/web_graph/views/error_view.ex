defmodule WebGraph.ErrorView do
  # use WebGraph, :view

  # # If you want to customize a particular status code
  # # for a certain format, you may uncomment below.
  # # def render("500.json", _assigns) do
  # #   %{errors: %{detail: "Internal Server Error"}}
  # # end

  # # By default, Phoenix returns the status message from
  # # the template name. For example, "404.json" becomes
  # # "Not Found".
  # def template_not_found(template, _assigns) do
  #   %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  # end
  use WebGraph, :view

  def render("404.html", _assigns) do
    "Page not found"
  end

  def render("500.html", _assigns) do
    "Internal server error"
  end

  # In case no render clause matches or no
  # template is found, let's render it as 500
  def template_not_found(_template, assigns) do
    render "500.html", assigns
  end
end
