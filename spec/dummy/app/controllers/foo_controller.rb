# frozen_string_literal: true
class FooController < ActionController::Base
  def create
    foo = Foo.create(params.permit(:uuid, :other))
    return render text: foo.errors, status: :bad_request if foo.errors?
    render text: foo.errors, status: :ok
  end
end
