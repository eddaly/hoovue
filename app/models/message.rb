class Message < ActiveRecord::Base
  attr_accessible :body, :recipient_uid, :sender_id, :subject
  attr_accessor :recipient_name

  belongs_to :sender, foreign_key: :sender_id, class_name: "User"

	validates :body, :subject, :sender, :recipient_uid, presence: true

	after_create :send_message

  def send_message()
    sender_chat_id = "-#{sender.uid}@chat.facebook.com"
    recipient_chat_id = "-#{recipient_uid}@chat.facebook.com"
     
    jabber_message = Jabber::Message.new(recipient_chat_id, body)
    jabber_message.subject = subject
     
    client = Jabber::Client.new(Jabber::JID.new(sender_chat_id))
    client.connect

    client.auth_sasl(Jabber::SASL::XFacebookPlatform.new(client,
      ENV.fetch('FACEBOOK_APP_ID'), sender.oauth_token,
      ENV.fetch('FACEBOOK_SECRET')), nil)

    client.send(jabber_message)
    client.close
  end
end
