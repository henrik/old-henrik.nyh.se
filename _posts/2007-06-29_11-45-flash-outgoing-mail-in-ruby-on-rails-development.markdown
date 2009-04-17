--- 
wordpress_id: 160
title: Flash outgoing mail in Ruby on Rails development
tags: 
- Ruby
- Ruby on Rails
---
<p class="center"><img src="http://henrik.nyh.se/uploads/flash-mail.png" alt="[Screenshot]" /></p>

In Ruby on Rails web apps, you can use <a href="http://am.rubyonrails.com/">ActionMailer</a> to send mail (and process incoming mail). This is useful for e.g. account confirmation and password recovery.

When developing the application, you might not want any mails to actually be sent. This can be configured in <code>config/environments/development.rb</code>. The default development configuration of ActionMailer is to actually send mails, but to ignore delivery errors. It's easy to make it not send anything:

{% highlight ruby %}
config.action_mailer.delivery_method = :test
{% endhighlight %}

With this setting, outgoing mail will just be appended to the <code>ActionMailer::Base.deliveries</code> array. That's all well and good, but it'd be nice to see the contents of those mails as they're appended. This turned out to be a relatively simple matter.

<!--more-->

Make the

{% highlight ruby %}
config.action_mailer.delivery_method = :test
{% endhighlight %}
setting in <code>config/environments/development.rb</code> as mentioned above. In the same file, also

{% highlight ruby %}
require "flash_mail"
{% endhighlight %}

Add <a href="http://henrik.nyh.se/uploads/flash_mail.rb"><code>flash_mail.rb</code></a> to the <code>lib</code> directory:

{% highlight ruby %}
# By Henrik Nyh <http://henrik.nyh.se> 2007-06-29
# http://henrik.nyh.se/2007/06/flash-outgoing-mail-in-ruby-on-rails-development
# Free to modify and redistribute with due credit.

module FlashMail  
  module ControllerTracking
    
    def self.included(action_controller)
      action_controller.instance_eval do
        before_filter  :set_current_controller
        cattr_accessor :current_controller
      end
    end
    
  protected    

    def set_current_controller
      ApplicationController.current_controller = self
    end
    
  end
  module Delivery

    def self.included(action_mailer)
      action_mailer.instance_eval do
        alias_method_chain :deliver!, :flash
      end
    end

    def deliver_with_flash!(*args)
      deliver_without_flash!(*args)
      if controller = ApplicationController.current_controller
        controller.instance_eval { flash[:mail] = ActionMailer::Base.deliveries.last }
      end
    end

  end
end

ActionMailer::Base.send     :include, FlashMail::Delivery
ActionController::Base.send :include, FlashMail::ControllerTracking
{% endhighlight %}

This extension does a few things:

The <code>ApplicationController</code> class gets a <code>current_controller</code> accessor. This accessor is used to store the current controller object in a before filter. The point of this is to give <code>ActionMailer</code> a handle on the current controller.

The <code>ActionMailer</code> <code>deliver!</code> method is wrapped to make the current controller set <code>flash[:mail]</code> to the last mail – the one just pushed onto the array.

That's pretty much it. Restart the server to have it pick up on the added extension. Make your views output <code>flash[:mail]</code> if it exists, and style to taste. I do 

{% highlight rhtml %}
<% f = flash.to_hash  # A real hash is easier to manipulate without deprecation nags, and should be safe enough %>
<% if f[:mail] %>
  <div id="mail_flash">
    <h4>Mail that would have been sent:</h4>
    <pre><%= auto_link(h(f.delete(:mail))) %></pre>
    <p><%= link_to_function("Discard", "mf = document.getElementById('mail_flash'); mf.parentNode.removeChild(mf)") %></p>

  </div>
<% end %>
<% unless f.empty? %>
  <ul id="messages">
    <% f.each do |kind, msg| %>
      <li class="<%= kind %>"><%= msg %></li>
    <% end %>
  </ul>
<% end %>
{% endhighlight %}

and

{% highlight css %}
#mail_flash {
  background: #FCF2B8;
  -moz-border-radius: 10px;
  padding:1.5em;
  margin-bottom:1em;
}

#mail_flash pre {
  margin: 1.5em 0;
}

#mail_flash p {
  font-weight: bold;
}
{% endhighlight %}
.
