# encoding: utf-8

module Rubocop
  module Cop
    module Lint
      # This cop checks for comparison of something with itself.
      #
      # @example
      #
      #  x.top >= x.top
      class UselessComparison < Cop
        MSG = 'Comparison of something with itself detected.'

        OPS = %w(== === != < > <= >= <=>)

        def on_send(node)
          op = node.loc.selector.source

          if OPS.include?(op)
            receiver, _method, selector = *node

            if receiver == selector
              add_offence(:warning, node.loc.selector, MSG)
            end
          end
        end
      end
    end
  end
end
