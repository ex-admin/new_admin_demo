defmodule TalonDemo.Talon.Web do
  @moduledoc """
  A module defining __using__ hooks for controllers,
  views and so on.

  This can be used in your application as:

      use Talon.Web, :controller
      use Talon.Web, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below.
  """

  def model(_) do
    quote do
      use Ecto.Schema

      import Ecto
      import Ecto.Changeset
      import Ecto.Query

      def all, do: TalonDemo.Repo.all(__MODULE__)
    end
  end

  def resource(_) do
    quote do
      import Ecto.Query
      import TalonDemo.Web.Gettext
      require TalonDemo.Web.Gettext
    end
  end

  def controller(_) do
    quote do
      use Phoenix.Controller

      alias TalonDemo.Repo
      import Ecto
      import Ecto.Query

      import TalonDemo.Web.Router.Helpers
      import TalonDemo.Web.Gettext
    end
  end

  def view(opts) do
    quote do
      use Talon.View

      opts = unquote(opts)
      #use Phoenix.View, root: "lib/talon_demo/talon/templates/talon/#{opts[:theme]}", namespace: opts[:module]
      use Phoenix.View, root: "lib/talon_demo/talon/templates/#{opts[:theme]}", namespace: opts[:module]

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_csrf_token: 0, get_flash: 2, view_module: 1]

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      import TalonDemo.Web.Router.Helpers
      import TalonDemo.Web.ErrorHelpers
      import TalonDemo.Web.Gettext
    end
  end

  def component_view(opts) do
    quote do
      use Talon.View

      opts = unquote(opts)
      # use Phoenix.View, root: "lib/talon_demo/talon/templates/talon/#{opts[:theme]}/components", namespace: opts[:module]
      use Phoenix.View, root: "lib/talon_demo/talon/templates/#{opts[:theme]}/components", namespace: opts[:module]

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_csrf_token: 0, get_flash: 2, view_module: 1]

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      import TalonDemo.Web.Router.Helpers
      import TalonDemo.Web.ErrorHelpers
      import TalonDemo.Web.Gettext
    end
  end

  def router(_) do
    quote do
      use Phoenix.Router
    end
  end

  def channel(_) do
    quote do
      use Phoenix.Channel

      alias TalonDemo.Repo
      import Ecto
      import Ecto.Query
      import TalonDemo.Web.Gettext
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
  defmacro __using__(opts) when is_list(opts) do
    apply(__MODULE__, opts[:which], [opts])
  end
end
