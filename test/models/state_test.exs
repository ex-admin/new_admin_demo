defmodule TalonDemo.StateTest do
  use TalonDemo.ModelCase

  alias TalonDemo.State

  @valid_attrs %{abbr: "some abbr", name: "some name"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = State.changeset(%State{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = State.changeset(%State{}, @invalid_attrs)
    refute changeset.valid?
  end
end
