# frozen_string_literal: true
# == Schema Information
#
# Table name: foos
#
#  id    :integer          not null, primary key
#  uuid  :string
#  other :string
#

class Foo < ActiveRecord::Base
  # validates_with UniqueOptimistic
  acts_as_unique
end
