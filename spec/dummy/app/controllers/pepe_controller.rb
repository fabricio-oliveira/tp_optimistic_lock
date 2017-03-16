# frozen_string_literal: true
class PepeController < ActionController::Base
  def create
    Pepe.create!(uuid: '5ea880de-e4ce-4770-8d10-c89bac181e40', other: 'bla bla')
    render nothing: true, status: :ok
  end
end
