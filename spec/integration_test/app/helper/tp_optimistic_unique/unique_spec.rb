# frozen_string_literal: true
require 'rails_helper'

RSpec.describe TPOptimisticUnique::Unique, type: :helper do
  describe 'create two model same uuid' do
    context 'When create two model same uuid' do
      let(:dummy) do
        create(:dummy)
      end

      let(:other_dummy) do
        create(:dummy, uuid: dummy.uuid)
      end

      it 'Does return status_code: 200' do
        expect{ dummy.errors }.not_to empty
      end
    end
  end
end
