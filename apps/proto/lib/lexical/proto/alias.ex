defmodule Lexical.Proto.Alias do
  alias Lexical.Proto.CompileMetadata
  alias Lexical.Proto.Field

  defmacro defalias(alias_definition) do
    caller_module = __CALLER__.module
    CompileMetadata.add_type_alias_module(caller_module)

    quote location: :keep do
      def parse(lsp_map) do
        Field.extract(unquote(alias_definition), :alias, lsp_map)
      end

      def definition do
        unquote(alias_definition)
      end

      def __meta__(:type) do
        :type_alias
      end

      def __meta__(:param_names) do
        []
      end

      def __meta__(:definition) do
        unquote(alias_definition)
      end

      def __meta__(:raw_definition) do
        unquote(Macro.escape(alias_definition))
      end
    end
  end
end
