# frozen_string_literal: true
class PepeController < ActionController::Base
  def create
    Pepe.create!(uuid: '5ea880de-e4ce-4770-8d10-c89bac181e40', other: 'bla bla')
    render nothing: true, status: :ok
  end

  # rescue_from StandardError, with: :handle_exception
  # rescue_from ActiveRecord::RecordInvalid, with: :handle_duplicated_exception
  #
  # def handle_exception
  #   render nothing: true, status: :internal_server_error
  # end
  #
  # def handle_duplicated_exception
  #   render nothing: true, status: :conflict
  # end
end
