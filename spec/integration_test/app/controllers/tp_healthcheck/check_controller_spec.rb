# frozen_string_literal: true
require 'rails_helper'

RSpec.describe TPHealthcheck::CheckController, type: :request do
  describe 'GET /healthchecks/ping' do
    context 'When get healthcheck' do
      before do
        get '/healthchecks/ping', nil, nil
      end

      it 'Does return status_code: 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'Does return name project Dummy' do
        expect(response.body).to eq 'Dummy'
      end
    end
  end

  describe 'GET /healthchecks/database' do
    context 'When database is up' do
      before do
        get '/healthchecks/database', nil, nil
      end

      it 'Does return status_code: 200' do
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'GET /healthchecks/service' do
    context 'When do not have microservice (or are not configurated file)' do
      before do
        allow(File).to receive(:exist?) { false }
        get '/healthchecks/service', nil, nil
      end

      it 'Does return status_code: 204' do
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'When have microservice configurate' do
      before do
        webmock.stub_request(:get, /api.github.com/)
          .with(headers: { 'Accept' => '*/*', 'User-Agent' => 'Ruby' })
          .to_return(status: 200, body: 'stubbed response', headers: {})
        get '/healthchecks/service', nil, nil
      end

      it 'Does return status_code: 200' do
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'GET /healthchecks/fake' do
    context 'When get inexistent url' do
      before do
        get '/healthchecks/fake', nil, nil
      end

      it 'Does return status_code: 404' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
