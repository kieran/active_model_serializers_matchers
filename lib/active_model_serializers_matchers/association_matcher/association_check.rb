module ActiveModelSerializersMatchers
  class AssociationMatcher
    class AssociationCheck
      attr_reader :matcher, :type

      def initialize(matcher, type)
        @matcher = matcher
        @type = type
      end

      def pass?
        return false if matcher.root_association.nil?
        matcher.root_association.superclass == association_type
      end

      def fail?
        !pass?
      end

      def description
        "#{ association_string } #{ matcher.root.inspect }"
      end

      def failure_message
        "expected #{ matcher.actual } to define a '#{ type } #{ matcher.root.inspect }' association"
      end

      private

      def association_type
        case type
        when :has_one
          ActiveModel::Serializer::Associations::HasOne
        when :has_many
          ActiveModel::Serializer::Associations::HasMany
        else
          raise ArgumentError, "'#{type}' is an invalid association type."
        end
      end

      def association_string
        case type
        when :has_one
          'have one'
        when :has_many
          'have many'
        end
      end
    end
  end
end
