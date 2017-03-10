# frozen_string_literal: true

module TPRecordOptimistic
  require 'tp_record_optimistic/engine' if defined?(Rails)
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

  alias save save_optimistic

  def optimistic_unique(args = {}); end
end

ActiveRecord::Base.send(:include, TPRecordOptimistic)
