# frozen_string_literal: true
require 'active_record' unless defined? ActiveRecord

module SQLErrorParse
  def unique_errors(error)
    table = self.class.table_name
    split_key = /(INSERT|UPDATE)/
    especific_key = %w(UNIQUE constraint failed: SQLite3::ConstraintException:)
    error.split(split_key)[0].split
         .reject { |e| especific_key.include? e }
         .map { |e| e.sub("#{table}.", '').delete(':') }
         .map(&:to_sym)
  end
end

module TPRecordOptimistic
  extend ActiveSupport::Concern
  include SQLErrorParse

  def save(*args)
    super(*args)
  end

  alias old_save save

  def save_optimistic(*args)
    old_save(*args)
  rescue ActiveRecord::RecordNotUnique => e
    unique_errors(e.to_s).each do |field|
      errors.add(field, :Unique, message: "UNIQUE constraint failed #{field}")
    end
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
