--- 
wordpress_id: 149
title: Colored SSH terminals in OS X
tags: 
- OS X
---
<p class="center"><img src="http://henrik.nyh.se/uploads/colored-terminals.png" alt="" /></p>

With the bundled terminal app in OS X, it's possible to save and re-establish SSH connections in the GUI. Furthermore, you can customize the terminal colors (and various other things) and save that along with the connection, so that you easily can establish SSH connections that can be told apart at a glance.

As if that wasn't enough, <a href="quicksilver.blacktree.com/">Quicksilver</a> can be made to index the saved sessions for even easier reconnection.

<!--more-->

<h4>Set up the SSH connection</h4>

<p class="center"><img src="http://henrik.nyh.se/uploads/colored-terminals_connect.png" alt="" /></p>

Hit <code>File &gt; Connect to Server… (&#x21E7;&#x2318;K)</code>. Select "Secure Shell (ssh)" in the left column, then click the "+" button under the right column. A prompt should appear. Input the server address, e.g. "example.com", and press "OK". Select that server in the right column and specify a username in the "User" field. This is not necessary if the remote username is the same as you use locally.

Hit the "Connect" button and a SSH connection should be established. If you don't want to be prompted for the password when connecting, you can <a href="http://wiki.dreamhost.com/SSH#Passwordless_Login">set up RSA keys</a>.

<h4>Customize colors</h4>

<p class="center"><img src="http://henrik.nyh.se/uploads/colored-terminals_color" alt="" /></p>

Select <code>Terminal &gt; Window Settings…</code>. In the "Color" panel, customize to your heart's content. You can change font and cursor style in the "Display" panel.

<h4>Save</h4>

<p class="center"><img src="http://henrik.nyh.se/uploads/colored-terminals_save.png" alt="" /></p>

When you're satisfied, do <code>File &gt; Save (&#x2318;S)</code>. Specify some recognizable name and keep all the defaults.

You're now free to remove the connection from "Connect to Server" if you feel like it; the SSH settings are saved with the window.

<h4>Open</h4>

To re-establish the saved connection, with the customized colors, just <code>File &gt; Open…  (&#x2318;O)</code>. When the "Open" dialog appears, start typing the name to select the file and hit <code>&#x21A9;</code> to open it.

The files are by default saved in <code>~/Library/Application Support/Terminal</code>. If you add that directory to the Quicksilver catalog, you can use Quicksilver to trigger connections.

<p class="center"><img src="http://henrik.nyh.se/uploads/colored-terminals_qsprefs.png" alt="" /></p>

Open Quicksilver and hit <code>&#x2318;,</code> for the "Preferences" window. Find the "Catalog" pane and select "Custom". Click the "+" and select "File &amp; Folder Scanner". Select the "Terminal" directory. Set "Include Contents: Folder Contents". Some more options should appear. Check "Omit source item" to just index the saved windows, not the "Terminal" directory itself. Hit the circular arrow in the bottom-right to rescan the catalog.

<p class="center"><img src="http://henrik.nyh.se/uploads/colored-terminals_qs.png" alt="" /></p>

If everything worked as it should, you can now open your saved, colored SSH terminals straight from Quicksilver. Enjoy!
