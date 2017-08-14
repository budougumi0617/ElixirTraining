defmodule Issues.Mixfile do
  use Mix.Project

  def project do
    [app: :issues,
     escript: escript_config,
     version: "0.1.0",
     build_path: "../../_build",
     config_path: "../../config/config.exs",
     deps_path: "../../deps",
     lockfile: "../../mix.lock",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     name: "Issues",
     source_url: "https://github.com/budougumi0617/ElixirTraining/app/issues",
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger, :httpoison ]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # To depend on another app inside the umbrella:
  #
  #   {:my_app, in_umbrella: true}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:credo, "~> 0.8", only: [:dev, :test], runtime: false},
      {:httpoison, "~> 0.8"},
      {:poison, "~> 1.5"},
      {:ex_doc, "~> 0.11"},
      {:earmark, ">= 0.0.0"}
    ]
  end

  defp escript_config do
    [ main_module: Issues.CLI ]
  end
end
