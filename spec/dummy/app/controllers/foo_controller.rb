# frozen_string_literal: true
class FooController < ActionController::Base
  def create
    foo = Foo.create(params.permit(:uuid, :other))
    p 'teste'
    return render nothing: true, status: :bad_request unless foo.errors.empty?
    render nothing: true, status: :ok
  end
end
