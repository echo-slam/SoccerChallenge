require 'test_helper'

class TimeSlotsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get time_slots_new_url
    assert_response :success
  end

  test "should get create" do
    get time_slots_create_url
    assert_response :success
  end

end
