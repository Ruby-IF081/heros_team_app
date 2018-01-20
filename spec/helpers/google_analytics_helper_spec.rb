require 'rails_helper'

describe GoogleAnalyticsHelper, type: :helper do
  describe 'render google analytics javascript' do
    context 'production environment' do
      let!(:expected_text) { 'window.dataLayer = window.dataLayer || [];' }

      before(:each) do
        allow(Rails).to receive(:env).and_return(ActiveSupport::StringInquirer.new("production"))
      end

      it 'should rander google analytics partial' do
        expect(helper.render_google_analytics).to have_text(expected_text)
      end
    end

    context '(non production) test environment' do
      it 'should not rander google analytics partial' do
        expect(helper.render_google_analytics).to eq(nil)
      end
    end
  end
end
