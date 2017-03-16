# frozen_string_literal: true
require 'rails_helper'

RSpec.describe TPRecordOptimistic, type: :request do
  describe 'create two model same uuid' do
    context 'When unique is activated' do
      before do
        post foo_index_path
        post foo_index_path
      end

      it 'Does return status_code: 400' do
        expect(response.status).to eq 400
      end
    end

    context 'When unique is activated and create' do
      before do
        post pepe_index_path
        post pepe_index_path
      end

      it 'Does return status_code: 409' do
        expect(response.status).to eq 409
      end
    end

    context 'When unique is not activated' do
      before do
        post bar_index_path
      end

      let(:uuid) do
        SecureRandom.uuid
      end

      it 'Does return status_code: 400' do
        expect { post bar_index_path }.to raise_error(ActiveRecord::RecordNotUnique)
      end
    end
  end
end
