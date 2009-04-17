--- 
wordpress_id: 155
title: An alternative to password confirmation
tags: 
- JavaScript
- Ruby
- Annoyances
- Ruby on Rails
---
I'm not a big fan of password confirmation in signup forms. Usually you see something like this:

<p class="center"><img src="http://henrik.nyh.se/uploads/password_confirmation-old.png" alt="[Signup form with password field and password confirmation field]" class="bordered" style="padding:5px" /></p>

For one thing, the more items in a registration form, the more you're turned off from signing up. Reducing the form above by 25% would do a lot.

For another thing, it's annoying to retype information when you shouldn't have to.

<!--more-->

The point of password confirmation as I understand it is this: you may be signing up with someone untrustworthy looking over your shoulder. For this reason, the password you input is not echoed to the screen. As a side effect, this makes it harder to notice typos. Since typos effectively mean locking yourself out, you're required to type the password again to lessen the chances.

One problem is that while this will catch a one-off slip of the fingers, it won't stop you from making consistent typos. So if you have butter fingers and press "s" instead of "a" twice over, tough luck. My main annoyance with password confirmation, though, is simply that – for me, and I should think most people – the more common usage case by far is signing up in private, not with people peering over my shoulder.

<h4>An alternative solution</h4>

For a site I'm developing, I came up with something I like better. In short: echo the password back to the user in a single input field with no confirmation, but make sure to inform that this happens, and offer a non-echoing, confirming form as well. I'm sure I'm not the first person to think of this, but I can't recall ever seeing this on a site.

So instead of the four-field behemoth above, the user is seduced by something like

<p class="center"><img src="http://henrik.nyh.se/uploads/password_confirmation-clear.png" alt="[Signup form with clear text password field]" class="bordered" style="padding:5px" /></p>

The link informs that the password will be echoed in clear text and also offers a way to toggle this behavior. I think the link text, "Don't show what I type", pulls that off very succinctly. It was a key point for me to not replace the annoying confirmation field with an equally annoying half-page essay, while still making it reasonably clear what's going on lest you type your password in clear text in front of Stranger Danger.

The toggle brings you

<p class="center"><img src="http://henrik.nyh.se/uploads/password_confirmation-hidden.png" alt="[Signup form with password field and password confirmation field]" class="bordered" style="padding:5px" /></p>

The form changes on-the-fly without reloading the page, using JavaScript. By the principle of <a href="http://en.wikipedia.org/wiki/Progressive_enhancement">progressive enhancement</a>, users without JavaScript simply see the form with password confirmation and no toggle link. One could let non-JavaScript users fall back on a regular link to a new page with a different form, but that would effectively reset the form if it had any input already, so I'd suggest against.

<h4>Ruby on Rails/JavaScript code</h4>

Below is the significant part of the <code>users/new.rhtml</code> Ruby on Rails view I use for the site I'm developing. I added this as a proof-of-concept and haven't yet taken the time to ensure valid XHTML and do much tidywork. Still, please do suggest any improvements. 

Since most of this is JavaScript (using <a href="http://www.prototypejs.org/">Prototype</a>), it should be of use to non-Ruby on Rails developers as well.

<code>apply_behaviour</code> is a method provided by <a href="http://www.ujs4rails.com/">the Unobtrusive Javascript for Ruby on Rails plugin</a>. In this case, it basically amounts to sticking the JavaScript in an external file and running it when the <code>id="password_label"</code> node is available in the DOM. <code>this</code> in the code refers to that node.

{% highlight rhtml %}
<%= error_messages_for :user %>

<% form_for :user, :url => users_path, :html => {:id => 'registration_form'} do |f| -%>
<p>
  <label for="username">Username</label><br/>
  <%= f.text_field :username %>
</p>

<p>
  <label for="email">E-mail address</label><br/>
  <%= f.text_field :email %>
</p>

<p>
  <label for="password" id="password_label">Password</label><br/>
  <%= f.password_field :password %></p>

<% apply_behaviour('#password_label', %{
  const offString = "Don't show what I type", onString = "Show what I type";
  var a = document.createElement("a");
  this.appendChild(document.createTextNode(" (")); this.appendChild(a); this.appendChild(document.createTextNode(")"));
   
  function isShowing() { return $('user_password').type == 'text'; }
  function mirror_password() { $('user_password_confirmation').value = $F('user_password'); } 
  function mirror_password_conditional() { if (isShowing()) mirror_password(); }
  function toggle_confirmation(mirrorPassword) {
    $('confirmation').toggle();
    $('user_password').type = isShowing() ? 'password' : 'text';
    a.innerHTML = isShowing() ? offString : onString;
    $('confirm_password').value = isShowing() ? 'false' : 'true';
    if (mirrorPassword) mirror_password();
  }

  toggle_confirmation(false);
  #{params[:confirm_password]=='true' ? 'toggle_confirmation(false);' : ''}
  Event.observe(a, 'click', toggle_confirmation);
  Event.observe('registration_form', 'submit', mirror_password_conditional);
}) %>
<%= hidden_field_tag 'confirm_password', 'true' %>

<p id="confirmation">
  <label for="password_confirmation">Confirm password</label><br/>
  <%= f.password_field :password_confirmation %>
</p>

<p>
  <%= submit_tag 'Sign up' %>
</p>
{% endhighlight %}
