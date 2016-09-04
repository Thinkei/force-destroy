require "force/destroy/version"

module Force
  module Destroy
    extend ::ActiveSupport::Concern
    # ActiveRecord's CollectionAssociation.valid_dependent_options
    DELETE_KEYWORDS = [:destroy, :delete, :delete_all]

    def force_destroy!
      begin
        @_destroying ||= false
        return if @_destroying
        @_destroying = true
        self.class.transaction do
          self.class.related_assocs.each do |assoc|
            self.send(assoc[:name]).send("force_destroy#{assoc[:collection] ? '_all!': '!'}")
          end
          self.delete
        end
      ensure
        @_destroying = false
      end
    end

    module ClassMethods
      def force_destroy_all!
        find_each do |record|
          record.force_destroy!
        end
      end

      def related_assocs
        @related_assocs ||= reflections.select do |name, assoc|
          assoc.options[:dependent].in?(DELETE_KEYWORDS)
        end.collect { |name, assoc| { name: name, collection: assoc.collection? } }
      end
    end
  end
end

class ActiveRecord::Base
  include Force::Destroy
end
