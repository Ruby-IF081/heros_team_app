require 'rails_helper'

describe BreadcrumbsHelper, type: :helper do
  describe '#page_breadcrumbs' do
    let!(:expected_html) do
      "<ul class=\"breadcrumb\"><li class=\"breadcrumb-item\">"\
                    "<a href=\"#{account_root_path}\">Dashboard</a></li></ul>"
    end
    it 'returns the right breadcrumb' do
      expect(helper.render_breadcrumbs('Dashboard' => account_root_path)).to eq(expected_html)
    end
  end
end
