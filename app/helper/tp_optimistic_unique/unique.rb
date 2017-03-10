# frozen_string_literal: true
class TPOptimisticUnique::Unique
  def save(*args)
    super(*args)
  rescue ActiveRecord::RecordNotUnique => e
    errors.add('all', e.to_s)
    return nil
  end
end
