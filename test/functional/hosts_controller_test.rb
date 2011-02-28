require 'test_helper'

class HostsControllerTest < ActionController::TestCase
  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Host.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Host.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to "/"
    assert_equal assigns['host'].id, session['host_id']
  end

  def test_edit_without_user
    get :edit, :id => "ignored"
    assert_redirected_to login_url
  end

  def test_edit
    @controller.stubs(:current_host).returns(Host.first)
    get :edit, :id => "ignored"
    assert_template 'edit'
  end

  def test_update_without_user
    put :update, :id => "ignored"
    assert_redirected_to login_url
  end

  def test_update_invalid
    @controller.stubs(:current_host).returns(Host.first)
    Host.any_instance.stubs(:valid?).returns(false)
    put :update, :id => "ignored"
    assert_template 'edit'
  end

  def test_update_valid
    @controller.stubs(:current_host).returns(Host.first)
    Host.any_instance.stubs(:valid?).returns(true)
    put :update, :id => "ignored"
    assert_redirected_to "/"
  end
end
