class ApplicationInteraction < ActiveInteraction::Base
  def success?(*)
    if instance_variable_defined?(:@_interaction_valid)
      return @_interaction_valid
    end
    if errors.any?
      return @_interaction_valid = false
    end
    super
  end
end
