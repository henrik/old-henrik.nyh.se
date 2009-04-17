--- 
wordpress_id: 211
title: with_unprotected_attributes Rails plugin
tags: 
- Ruby
---
I generalized <a href="http://henrik.nyh.se/2007/10/bypassing-attr_accessible-and-attr_protected-for-test-factories">bypassing <code>attr_accessible</code> and <code>attr_protected</code> for test factories</a>.

The new version is a plugin and can be used outside tests as well. It supports unprotected versions of <code>create</code>, <code>create!</code> and <code>new</code>. ActiveRecord::Base gets a <code>with_unprotected_attributes</code> class method. Pass it a block and anything inside will be done with unprotected attributes.

<a href="http://pastie.textmate.org/pastes/148227/download">Get it here</a> (<a href="http://pastie.textmate.org/148227">highlighted source</a>).

Save that file as <code>vendor/plugins/with_unprotected_attributes/init.rb</code>, or stick it in <code>environment.rb</code>, or put it in a file in <code>lib</code> and require it.
