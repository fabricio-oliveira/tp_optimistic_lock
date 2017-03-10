# frozen_string_literal: true
require 'active_record' unless defined? ActiveRecord

module TPRecordOptimistic
  extend ActiveSupport::Concern

  def save(*args)
    super(*args)
  end

  alias old_save save

  def save_optimistic(*args)
    old_save(*args)
  rescue ActiveRecord::RecordNotUnique => e
    errors.add('all', e.to_s)
    return false
  end

  def optimistic_unique(_args = {})
    alias_method :save, :save_optimistic
  end
end

# ActiveRecord::Base.send(:include, TPRecordOptimistic)

ActiveSupport.on_load(:active_record) do
  class ActiveRecord::Base
    def self.included(base)
      base.send(:include, TPRecordOptimistic)
    end
  end
end
