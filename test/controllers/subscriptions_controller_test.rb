require "test_helper"

describe SubscriptionsController do

  before do
    @subscription = subscriptions(:one)
  end

  it "must get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:subscriptions)
  end

  it "must get new" do
    get :new
    assert_response :success
  end

  it "must create subscription" do
    assert_difference('Subscription.count') do
      post :create, subscription: {  }
    end

    assert_redirected_to subscription_path(assigns(:subscription))
  end

  it "must show subscription" do
    get :show, id: @subscription
    assert_response :success
  end

  it "must get edit" do
    get :edit, id: @subscription
    assert_response :success
  end

  it "must update subscription" do
    put :update, id: @subscription, subscription: {  }
    assert_redirected_to subscription_path(assigns(:subscription))
  end

  it "must destroy subscription" do
    assert_difference('Subscription.count', -1) do
      delete :destroy, id: @subscription
    end

    assert_redirected_to subscriptions_path
  end

end
