require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Host.stubs(:authenticate).returns(nil)
    post :create
    assert_template 'new'
    assert_nil session['host_id']
  end

  def test_create_valid
    Host.stubs(:authenticate).returns(Host.first)
    post :create
    assert_redirected_to "/"
    assert_equal Host.first.id, session['host_id']
  end
end
