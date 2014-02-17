class SubscriptionsController < InheritedResources::Base

  def create
    # get params from form
    email = params[:email]
    plan_id = params[:plan_id]
    token = params[:stripeToken]

    # create a new subscription in the database
    if current_user.subscription.present?
      s =  current_user.subscription.update_attributes(
        email: email,
        plan_id: plan_id,
        stripe_token: token
      )

      c = Stripe::Customer.retrieve(current_user.subscription.stripe_cus_id)
      c.email = email
      c.plan = plan_id
      c.card = token
      c.save
    else
      # create a new customer and associate them with a subscription plan
      c = Stripe::Customer.create(
        card: token,
        plan: plan_id,
        email: email
      )

      s =  current_user.create_subscription(
        email: email,
        plan_id: plan_id,
        stripe_token: token,
        stripe_cus_id: c.id
      )
    end
    flash[:notice] = "You have created a subscription."
    redirect_to subscriptions_path

  # handle errors
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to root_path
  end


  private

  def subscription_params
    params.require(:subscription).permit(
      :email, :plan_id, :stripeToken
    )
  end
end
