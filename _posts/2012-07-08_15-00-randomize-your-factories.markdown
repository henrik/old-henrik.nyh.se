---
title: Randomize your factories
tags:  [FactoryGirl, Factories, Testing, Ruby on Rails]
---

[FactoryGirl](https://github.com/thoughtbot/factory_girl/) is a Ruby library to create data for tests.

I read Arjan van der Gaag's [FactoryGirl Tips and Tricks](http://arjanvandergaag.nl/blog/factory_girl_tips.html) post the other day and found myself disagreeing with a few of the points. Mainly the one where Arjan recommends not using randomized attribute values because they can cause unexpected results in tests.

A randomized attribute value could be something like

{% highlight ruby %}
FactoryGirl.define do
  factory(:user) do
    gender { ["male", "female", "other"].sample }
  end
end
{% endhighlight %}

Whenever you generate a user for a test, you don't know what gender that user will have unless you explicitly state it:

{% highlight ruby %}
FactoryGirl.build(:user)  # Any gender.
FactoryGirl.build(:user, gender: "female")  # Definitely female.
{% endhighlight %}

Or you could define and use a more specific factory (or use [traits](https://github.com/thoughtbot/factory_girl/)):

{% highlight ruby %}
FactoryGirl.define do
  factory(:user) do
    gender { ["male", "female", "other"].sample }

    factory(:female_user) do
      gender "female"
    end
  end
end

FactoryGirl.build(:female_user)  # Definitely female.
{% endhighlight %}

I think you should only ever rely on the `:user` factory to give you a user. Possibly you could also assume that it's a valid one, and that it has the object graph that a real user would have. But no specific, implicit set of valid attributes should be assumed.

If you're writing a test that applies to users, you fabricate a `:user`. If you're writing a test that applies specifically to female users, you fabricate a `:female_user`, or set that attribute. If you write a test that makes no mention of the user gender, it should pass no matter the gender.


## Fixtures vs. factories

If you do assume certain attributes, your factory is more like the [Ruby on Rails fixtures](http://guides.rubyonrails.org/testing.html#the-low-down-on-fixtures) that many people use factories to get away from. If you're writing a test that is explicitly for any user, what's the value in implicitly knowing their sex? This post is making the case that there is value in making sure you *don't* know. This is, of course, also one advantage of factories over fixtures.


## Random failures

It's true that randomized attributes means tests can fail randomly. That's certainly not ideal. But the alternative is that your app has that same bug, only without ever failing.

Say you write not-at-all-contrived code like this:

{% highlight ruby %}
class User
  def title
    case gender
    when "male"
      "Mr."
    when "female"
      "Ms."
    end
  end
end
{% endhighlight %}

You've made the mistake of assuming user genders are only ever "male" or "female", but they can also be "other". (As an aside, gender identity and gender choices in forms is interesting and complex – just these three options wouldn't satisfy everyone.)

Now, if your tests always generate female users, this will probably never fail. But if attributes are randomized, you can catch mistakes. Maybe a request test suddenly blows up because something expected a string title but got a nil value.

Certainly, these failures can be a bit frustrating, because they're harder to reproduce. But would you really prefer to have a perfectly reproducible case of not catching the issue at all? Instead your production users, with their less predictable data, will find the bugs for you.

Once you've discovered this bug, you should of course write a test specifically for it, and one that fails predictably. Randomized attributes are certainly no substitute for that. What they are is a safety net, making up somewhat for the fact that you will make mistakes.

Curiously, Arjan's very next point is that you should test for explicit values, and not rely on factories to have certain implicit values. That is really much of my point. Randomized attribute values enforce this by not letting you rely on them even if you try.

Again, I'm not saying I think random test failures are great. Only that they're better than having a bug but no test failures whatsoever.


## Update – July 8, 2012 at 19:30 CEST:

[Arjan's post](http://arjanvandergaag.nl/blog/factory_girl_tips.html) was updated to address these points:

> One might argue (…) that random values help you discover bugs. While possible, that obviously means you have a bigger problem: holes in your test suite. (…) True, a cryptic error is better than no error, but randomised factories remain a poor substitute for proper unit tests, code review and TDD to prevent these problems.
>
> Randomised factories are therefore not only not worth the effort, they even give you false confidence in your tests, which is worse than having no tests at all.

Even if you do "proper unit tests, code review and TDD" as diligently as anyone, you will make mistakes and have bugs. And given those bugs, you have a chance of finding them sooner by doing it the way I described. I think I made it pretty clear above, but I will reiterate that I don't see randomized factories as a substitute for anything other than human infallibility. It's one more safety net.

If your tests and code review are good enough, you won't ever get the random test failures. You only get them when you mess up. Do TDD and code review, but do this too.

I think that Arjan's argument about giving false confidence in your tests is the strongest one. I can only say that I do this precisely because I have little confidence in my tests, or anyone else's. I don't rig the extra safety net so I can take more risks; I do it because I know that sooner or later, no matter how hard I try, I'll slip.


## Update – July 9, 2012 at 08:15 CEST:

The random failures don't even have to be random. Or rather, they don't have to be hard to reproduce.

I [just learned something from Mark Dodwell](https://twitter.com/madeofcode/status/222070153641328640) that I hadn't realized: when you have RSpec or MiniTest randomize the test order (`rspec --order random my_spec.rb`), the seed value that you get back isn't just for recreating that test order. That seed applies to any use of `Kernel#rand`, so it can make your random test failures reproducible too.
