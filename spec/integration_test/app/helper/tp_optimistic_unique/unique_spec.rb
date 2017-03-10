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

      it 'Does return status_code: 400' do
        expect(response.status).to eq 400
      end
    end
  end
end
