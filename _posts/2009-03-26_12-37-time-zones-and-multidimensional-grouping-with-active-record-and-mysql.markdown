--- 
wordpress_id: 273
title: Time zones and multidimensional grouping with Active Record and MySQL
tags: 
- Ruby
- Ruby on Rails
---
I've been writing a lot of statistics queries in Active Record/MySQL lately and noticed some possibly non-obvious things.

<h4>Time zones</h4>

Our database is configured to use UTC time. In Rails 2.1, we use <code>config.active_record.default_timezone = :utc</code>. In 2.3, I believe it's <code>config.time_zone = 'UTC'</code>, and set that way by default.

A lot of my statistics queries involved time ranges, grouping per day or only using data from a certain period. I found that a query like

{% highlight ruby %}
User.count(:conditions => ['created_at BETWEEN ? AND ?', some_day.beginning_of_day, some_day.end_of_day])
{% endhighlight %}
did not do any time zone conversions as you may expect. If <code>some_day.beginning_of_day</code> is a non-UTC local time (e.g. 00:00 on March 26th CET), that date and time is passed into the query as "2009-03-26 00:00:00" and compared to the UTC datetimes in the database.

Instead, you should do

{% highlight ruby %}
User.count(:conditions => ['created_at BETWEEN ? AND ?', some_day.beginning_of_day.utc, some_day.end_of_day.utc])
{% endhighlight %}
In this case, "2009-03-25 23:00:00" would be passed into the query.

If you want to do that another way, or to group on local-time dates, you could instead do something like

{% highlight ruby %}
User.count(:group => 'DATE(CONVERT_TZ(created_at, "UTC", "CET"))')
{% endhighlight %}

Without the conversion, it'd group on UTC dates instead of local CET dates. That would mean a customer that was created at 00:59 CET on March 26 would be grouped under March 25 instead.

Note that you need to <a href="http://dev.mysql.com/doc/refman/5.1/en/time-zone-support.html">set up the MySQL time zone tables</a> with something like

{% highlight bash %}
mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -u root mysql
{% endhighlight %}
On OS X with MySQL 5 from MacPorts, the invocation was

{% highlight bash %}
mysql_tzinfo_to_sql5 /usr/share/zoneinfo | mysql -u root mysql
{% endhighlight %}

Warnings about time zones that couldn't be loaded are fine as long as they're not the ones you're using.

You can convert time zones without those tables, but then you need to specify the UTC offset manually, and since it changes with daylight saving, I wouldn't recommend it.

<h4>Multidimensional grouping</h4>

Another thing I noticed was that Active Record calculation queries (using e.g. <code>.count</code>) don't seem to support grouping by multiple columns at once. It's easy to do with <code>.all</code> and <code>#map</code>, though:

{% highlight ruby %}
Item.all(
  :select => 'COUNT(*) AS count, age, gender',
  :group => 'age, gender'
).map {|i| [i.age, i.gender, i.count.to_i] }
{% endhighlight %}
