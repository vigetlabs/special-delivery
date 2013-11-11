class SomeMailer < ActionMailer::Base
  include SpecialDelivery::Mailer

  def some_email
    special_delivery({
      :callback_class  => EmailCallback::SomeEmail,
      :callback_record => SampleResource.find }) do
      mail(:to => 'test@test.com', :from => 'example@example.org', :subject => 'Important Hyper E-Note')
    end
  end
end
