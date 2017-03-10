# frozen_string_literal: true
class TPRecordOptimistic::Unique
  def save(*args)
    super(*args)
  rescue ActiveRecord::RecordNotUnique => e
    errors.add('all', e.to_s)
    return false
  end
end
