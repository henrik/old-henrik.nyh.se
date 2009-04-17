--- 
wordpress_id: 100
title: Nike+ Challenge widget with kilometers
tags: 
- OS X
- Dashboard widgets
---
The <a href="http://www.apple.com/downloads/dashboard/status/nikechallengewidget.html">Nike+ Challenge widget</a> only displays miles, even if your preference is kilometers. I modified the widget to display kilometers instead. My version only displays kilometers, never miles.

<a href="http://henrik.nyh.se/uploads/MyChallenges.wdgt.zip">Download here</a>.

<div class="updated">
<h5>Updated 2007-05-04</h5>
Now works with the latest version of the widget. Use the download link above.

Small modifications were made to <code>nikepluschallenges.js</code> and <code>utils.js</code>:

{% highlight diff %}--- utils.js
+++ (clipboard)
@@ -166,9 +166,9 @@
 	else return floatNumber;
 }
 
+// Modified to actually return KM
 function getMilesFromKM(kilometers,precision){
-    kmToMiles = kilometers / 1.609344;
-    return cropFloat(kmToMiles+"",precision);
+    return cropFloat(kilometers+"",precision);
 }
 
 function bubblesort2DimArray(arrayList,key){

--- nikepluschallenges.js
+++ (clipboard)
@@ -455,7 +455,7 @@
 						getProgressInformationDistanceLimit(progress,comparatorValue,isCurrentUser,isWinner);
 					break;
 				case "mostDistance": 
-					challengeDiv += getProgessInformationDistanceTime(progress,leadersProgress,comparatorValue,isCurrentUser,isWinner);
+					challengeDiv += getProgessInformationDistanceTime(progress,leadersProgress,comparatorValue,isCurrentUser,isWinner).replace(/ mi(?=<\/div>)/, ' km');
 					break;
 				case "fastestRun": 
 					challengeDiv += getProgressInformationDistanceFastest(progress,leadersProgress,comparatorValue,isCurrentUser,isWinner);{% endhighlight %}

The diff is mainly to illustrate what I changed. Patching straight from it might not work well due to <code>nikepluschallenges.js</code> using <code>\r</code> linebreaks, unlike <code>utils.js</code> and <a href="http://macromates.com">my editor</a>.
</div>
