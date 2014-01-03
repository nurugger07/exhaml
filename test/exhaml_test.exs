defmodule Exhaml do

  @line_matcher %r{(([ \t]+)?(.*?))(?:\Z|\r\n|\r|\n)}

  defrecordp :node, full: "",  tag: "", id: "", class: [], attributes: [], indent: 0, self_closing: true

  def render(haml), do: parse(haml)

  def parse(haml) do
    clean_haml(haml) |>
     haml_to_list    |>
     tokenize        |>
     process         |>
     Enum.join("\n")
  end

  def clean_haml(haml) do
    # remove unnescessary trailing whitespace 
    String.strip(haml)
  end

  def haml_to_list(haml) do
    # convert the haml into a list
    Regex.scan(@line, haml) |> Enum.drop(-1)
  end

  def tokenize_nodes([]), do: []
  def tokenize_nodes([[full, tag, tabs, _]|t]) do
    # iterate over the list to build nodes
    # get the tag
    tag = cond do
      Regex.match?(@div, tag) -> "div"
    end
    whitespace    = (String.split(tabs, %r/\t/) |> Enum.count) - 1
    self_closing  = Enum.member?(@self_closing, tag)
    [new_node(full, tag, whitespace, self_closing)] ++ tokenize_nodes(t)
  end

  def process_nodes[h|t]() do
    # process each node to list of html tags
  end

  def new_node(full, tag, whitespace, self_closing) do
    node(full: full,
  end

end

defmodule ExhamlTest do
  use ExUnit.Case

  test "parse div tags" do
    assert Exhaml.Line[tag: "div"] == Exhaml.parse("%div")
    assert Exhaml.Line[tag: "div", attributes: [{"data-class", "elixir"}]] == Exhaml.parse(".elixir")
  end

  test "parse tag with children" do
    assert true
  end

  test "parse other tags" do
    assert true
  end

  test "parse self closing tags" do
    assert true
    # "meta", "img", "link", "br", "hr", "input", "area", "base"
    # assert "<meta />" == Exhaml.render("%meta")
    # assert "<img />" == Exhaml.render("%img")
    # assert "<link />" == Exhaml.render("%link")
    # assert "<hr />" == Exhaml.render("%hr")
    # assert "<input />" == Exhaml.render("%input")
    # assert "<area />" == Exhaml.render("%area")
    # assert "<base />" == Exhaml.render("%base")
    # assert "<br />" == Exhaml.render("%br")
  end
end
