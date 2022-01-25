# frozen_string_literal: true

require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get signup_path

    assert_no_difference "User.count" do
      post users_path,
           params: {
             user: {
               name: "",
               email: "user@invalid",
               password: "123",
               password_confirmation: "456",
             },
           }
    end

    assert_template "users/new"

    assert_select "#error_explanation"
    assert_select ".alert.alert-danger"
    assert_select "#error_explanation>ul>li", count: 4
    assert_select ".field_with_errors", count: 8
  end
end
