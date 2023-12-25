# frozen_string_literal: true

require 'test_helper'

class CarControllerTest < ActionDispatch::IntegrationTest
  test 'should get show' do
    get car_show_url
    assert_response :success
  end
end
