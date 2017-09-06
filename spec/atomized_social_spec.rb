require 'spec_helper'

CALLBACK_URL = "https://127.0.0.1:3000/oauth/callback"

RSpec.describe AtomizedSocial do
  describe '#application' do
    it 'has a version number' do
      expect(AtomizedSocial::VERSION).not_to be nil
    end

    describe '#authenticate' do
      it 'is authenticating without params' do
        expect { AtomizedSocial.new.authenticate }.to raise_exception(ArgumentError)
      end

      it 'is authenticating with invalid params' do
        expect { AtomizedSocial.new.authenticate({}) }.to raise_exception(ArgumentError)
      end

      it 'is authenticating to unsupported network' do
        params = {
          callback_url: "https://127.0.0.1:3000/oauth/callback",
          key: 'some_key',
          secret: 'some_secret',
        }

        expect { AtomizedSocial.new.authenticate('tumblr', params) }.to raise_exception('Unsupported social network')
      end

      it 'is authenticating to twitter' do
        params = {
          callback_url: "https://127.0.0.1:3000/oauth/callback",
          key: 'dtSvYdaw6vItXXxWustz5fifB',
          secret: 'maMHUEesytK4lXrPsEjDPAFRQbSLahOMuKIM51RJ9JMeRfR89r'
        }

        expect(AtomizedSocial.new.authenticate('twitter', params)).to eq true
      end
    end
  end
end
