require 'spec_helper'

describe BreadcrumbsHelper do
  describe '#page_breadcrumbs' do
    it 'returns the right breadcrumb' do
      expected_html = "<ul class=\"breadcrumb\"><li class=\"breadcrumb-item\">"\
                    "<a href=\"http://test.host/account\">Dashboard</a></li></ul>"
      expect(helper.render_breadcrumbs('Dashboard' => account_root_url)).to eq(expected_html)
    end
  end
end
