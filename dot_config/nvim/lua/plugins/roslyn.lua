return {
  'seblj/roslyn.nvim',
  lazy = false,
  opts = {
    config = {
      settings = {
        ['csharp|background_analysis'] = {
          dotnet_analyzer_diagnostics_scope = 'fullSolution',
          dotnet_compiler_diagnostics_scope = 'fullSolution',
        },
        ['csharp|code_lens'] = {
          dotnet_enable_references_code_lens = true,
        },
        ['csharp|completion'] = {
          dotnet_show_name_completion_suggestions = true,
          dotnet_show_completion_items_from_unimported_namespaces = true,
          dotnet_provide_regex_completions = true,
        },
        ['csharp|highlighting'] = {
          dotnet_highlight_related_regex_components = true,
          dotnet_highlight_related_json_components = true,
        },
        ['csharp|inlay_hints'] = {
          csharp_enable_inlay_hints_for_implicit_object_creation = true,
          csharp_enable_inlay_hints_for_implicit_variable_types = true,
          csharp_enable_inlay_hints_for_lambda_parameter_types = true,
          csharp_enable_inlay_hints_for_types = true,
          dotnet_enable_inlay_hints_for_indexer_parameters = true,
          dotnet_enable_inlay_hints_for_literal_parameters = true,
          dotnet_enable_inlay_hints_for_object_creation_parameters = true,
          dotnet_enable_inlay_hints_for_other_parameters = true,
          dotnet_enable_inlay_hints_for_parameters = true,
          dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
          dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
          dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
        },
        ['csharp|symbol_search'] = {
          dotnet_search_reference_assemblies = true,
        },
        ['csharp|type_members'] = {
          dotnet_member_insertion_location = true,
          dotnet_property_generation_behavior = true,
        },
        ['navigation'] = {
          dotnet_navigate_to_decompiled_sources = true,
        },
      },
    },
  },
  config = function(_, opts)
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities =
      vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

    opts.config.capabilities = capabilities

    require('roslyn').setup(opts)
  end,
}
