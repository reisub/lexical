defmodule Lexical.RemoteControl.Search.Indexer.Module do
  alias Lexical.RemoteControl.Search.Indexer

  def index(module) do
    with true <- indexable?(module),
         {:ok, path, source} <- source_file_path(module) do
      Indexer.Source.index(path, source)
    end
  end

  def source_file_path(module) do
    with {:ok, %{file: file_path}} <- BeamFile.debug_info(module),
         {:ok, contents} <- File.read(file_path) do
      {:ok, file_path, contents}
    end
  end

  defp indexable?(Kernel.SpecialForms), do: false

  defp indexable?(module) do
    module_string = to_string(module)
    String.starts_with?(module_string, "Elixir.")
  end
end
