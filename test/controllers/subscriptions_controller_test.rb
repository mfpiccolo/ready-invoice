require "test_helper"

describe SubscriptionsController do

  before do
    @subscription = FactoryGirl.create(:subscription)
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

  describe "POST create" do
    before do
      @user = FactoryGirl.create(:user)
      @customer = OpenStruct.new(id: "abc123")
    end
    describe "with current_user subscription present" do
      before do
        @subscription = @user.create_subscription(stripe_cus_id: "abc123")
        SubscriptionsController.any_instance.stubs(:current_user).returns(@user)
        @subscription.expects(:update_attributes).with(:email => 'blah@blah.com', :plan_id => '1', :stripe_token => 'l0ng_t0k3n')
        Stripe::Customer.expects(:retrieve).with("abc123").returns(@customer)
        @customer.expects(:save)
      end

      it "updates subscription attributes locally and for stripe" do
        post :create, email: "blah@blah.com", plan_id: 1, stripeToken: "l0ng_t0k3n"
      end
    end

    describe "without current_user subscription present" do
      before do
        @subscription = @user
        Stripe::Customer.expects(:create)
          .with(:card => 'l0ng_t0k3n', :plan => '1', :email => 'blah@blah.com')
          .returns(@customer)
        SubscriptionsController.any_instance.stubs(:current_user).returns(@user)
        @user.expects(:create_subscription)
          .with(:email => 'blah@blah.com', :plan_id => '1', :stripe_token => 'l0ng_t0k3n', :stripe_cus_id => "abc123")
      end

      it "creates a new customer and associates them with a subscription plan" do
        post :create, email: "blah@blah.com", plan_id: 1, stripeToken: "l0ng_t0k3n"
      end
    end
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
