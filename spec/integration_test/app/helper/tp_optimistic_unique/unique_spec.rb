# frozen_string_literal: true
require 'rails_helper'

RSpec.describe TPRecordOptimistic::Unique, type: :request do
  describe 'create two model same uuid' do
    context 'When create two model same uuid' do
      before do
        post foo_index_path, params: { uuid: uuid, other: 'bla bla' }
        post foo_index_path, params: { uuid: uuid, other: 'bla bla' }
      end

      let(:uuid) do
        SecureRandom.uuid
      end

      it 'Does return status_code: 200' do
        expect(response.body).to eq 200
      end
    end
  end
end
