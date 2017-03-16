# frozen_string_literal: true
require 'active_record' unless defined? ActiveRecord
# require 'active_model' unless defined? ActiveModel

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

  def save!(*args)
    super(*args)
  end

  alias old_save! save!

  def save_optimistic!(*args)
    old_save!(*args)
  rescue ActiveRecord::RecordNotUnique => e
    errors.add('all', e.to_s)
    raise ActiveRecord::RecordInvalid, self
  end

  # def optimistic_unique
  #   alias_method :save, :save_optimistic
  # end
end

ActiveSupport.on_load(:active_record) do
  class ActiveRecord::Base
    def self.acts_as_unique
      include TPRecordOptimistic
      alias_method :save, :save_optimistic
      alias_method :save!, :save_optimistic!
    end
  end
end

# class UniqueOptimistic < ActiveModel::Validator
#   def validate(record)
#     record.class_eval do
#       include TPRecordOptimistic
#       record.send(:optimistic_unique)
#     end
#   end
# end
