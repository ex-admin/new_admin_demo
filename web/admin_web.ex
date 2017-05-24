defmodule ExAdmin.Web do
  @moduledoc """
  A module defining __using__ hooks for controllers,
  views and so on.

  This can be used in your application as:

      use ExAdmin.Web, :controller
      use ExAdmin.Web, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below.
  """

  def model do
    quote do
      use Ecto.Schema

      import Ecto
      import Ecto.Changeset
      import Ecto.Query

      def all, do: NewAdmin.Repo.all(__MODULE__)
    end
  end

  def controller do
    quote do
      use Phoenix.Controller

      alias NewAdmin.Repo
      import Ecto
      import Ecto.Query

      import NewAdmin.Router.Helpers
      import NewAdmin.Gettext
    end
  end

  def view do
    quote do

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_csrf_token: 0, get_flash: 2, view_module: 1]

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      import NewAdmin.Router.Helpers
      import NewAdmin.ErrorHelpers
      import NewAdmin.Gettext
    end
  end

  def router do
    quote do
      use Phoenix.Router
    end
  end

  def channel do
    quote do
      use Phoenix.Channel

      alias NewAdmin.Repo
      import Ecto
      import Ecto.Query
      import NewAdmin.Gettext
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
