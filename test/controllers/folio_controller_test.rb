require 'test_helper'

class FolioControllerTest < ActionController::TestCase
  test "should get folio" do
    get :folio
    assert_response :success
  end

end
