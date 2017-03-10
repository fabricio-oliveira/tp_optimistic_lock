# frozen_string_literal: true
class FooController < ActionController::Base
  def create
    foo = Foo.create(uuid: '5ea880de-e4ce-4770-8d10-c89bac181e40', other: 'bla bla')
    return render nothing: true, status: :bad_request unless foo.errors.empty?
    render nothing: true, status: :ok
  end
end
