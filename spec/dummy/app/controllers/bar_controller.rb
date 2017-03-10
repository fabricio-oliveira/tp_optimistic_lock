# frozen_string_literal: true
class BarController < ActionController::Base
  def create
    bar = Bar.create(uuid: '5ea880de-e4ce-4770-8d10-c89bac181e40', other: 'bla bla')
    return render nothing: true, status: :bad_request unless bar.errors.empty?
    render nothing: true, status: :ok
  end
end
