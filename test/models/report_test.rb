require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test "my_reports with scoped_search" do
    assert_equal Report.pluck(:id), Report.my_reports('hostgroup = One').pluck(:id)
  end

  test "my_reports via plain AR" do
    assert_equal Report.pluck(:id), Report.joins('host' => ['hostgroup']).where('hostgroups.name = "One"').pluck(:id)
  end
end
