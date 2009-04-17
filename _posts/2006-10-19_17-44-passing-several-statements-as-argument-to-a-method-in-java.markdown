--- 
wordpress_id: 72
title: Passing several statements as argument to a method in Java
tags: 
- Java
---
I know very little Java; I only use it when I have to, and I very rarely do.

Today I had to, and I wanted a way of passing a "block" of several statements into a method, to be run at a specific point within that method – something like what you could do with a Ruby block.

It was a bit tricky to figure out how to do this, but I managed (as far as I could tell). As I didn't find anything very helpful on Google, I thought I'd write it up in case it helps someone else.

<!--more-->

The solution is based on code from chapter 8 of <a href="http://www.mindview.net/Books/TIJ/">Thinking in Java</a> by Bruce Eckel, a free download.

If I'm doing something horribly wrong or needlessly complicated (for Java :p), please let me know.

<h4>The solution</h4>

The idea is to create an interface (something like a very abstract base class, with no data) that has one method; then make the method that should take the "block" accept objects implementing that interface, and trigger the method defined in the interface wherever the "block" should run.

When passing the "block" as an argument, an object is created of an anonymous inner class that implements the interface and defines its method to whatever the "block" should do.

Eckel has more details.

Code:

{% highlight Java %}
public class MyClass { 
 
  public interface Statements {
    void runStatements();
  }
 
  private void runInsideMe(Statements ss) {
    System.out.println("Running statements...");
    ss.runStatements();
    System.out.println("Ran them.");
  }
 
  public MyClass() {
    Statements arg = new Statements() {
      public void runStatements() {
        System.out.println("Statement 1!");
        System.out.println("Statement 2!");
      }
    };
    runInsideMe(arg);
  }

  public static void main (String[] args) {
    new MyClass();
  }

}
{% endhighlight %}

If you need to handle various return types for runStatements, you can use generics (JDK 1.5+). Apparently you can only use this with object return types (like <code>Integer</code>), not primitives (like <code>int</code>). Code:

{% highlight java %}
public class MyClass { 
 
  public interface Statements<X> {
    X runStatements();
  }
 
  private void runInsideMe(Statements ss) {
    System.out.println("Running statements...");
    System.out.println("Output: " + ss.runStatements());
    System.out.println("Ran them.");
  }
 
  public MyClass() {

    Statements arg = new Statements<String>() {
      public String runStatements() {
        String output = "foo" + "bar";
        return output;
      }
    };
    runInsideMe(arg);

    arg = new Statements<Integer>() {
      public Integer runStatements() {
        int output = 40 + 2;
        return new Integer(output);
      }
    };
    runInsideMe(arg);

  }

  public static void main (String[] args) {
    new MyClass();
  }

}
{% endhighlight %}
