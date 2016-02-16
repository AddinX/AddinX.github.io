---
title: Fluent ribbon - Concept and Installation
tags: [fluent_ribbon]
keywords: start, introduction, begin, install, 
audience: everyone
summary: "In this part, we discuss quickly about the concept behind the ribbon builder and see how to install it." 
series: "Fluent ribbon"
weight: 1
---

## Concept

The fluent ribbon builder separates the notion of UI and events. Firstly, the developer needs to define the UI part that will represent how will look like the controls within the tab(s). Then using the unique identifier of each control, the developer will be able to define the events that will be attach to each control.

The unique identifier of each control helps to link an events to the appropriate control. The library will manage the Excel callbacks of the controls and run the right event. This way it simplifies the life of the developer so he only as to focus on defining the UI and the events. As long as the identifiers are unique, the ribbon and the callbacks will be working at 100% as the library ensure that the UI and events are correctly linked together.

## Prerequisite

* You need to install the **Nuget package manager**. If you are using the latest Visual Studio, the extension is already installed. It is also possible to install a command-line utility in case you are not using Visual Studio. See all the information on this <a href="https://docs.nuget.org/consume/installing-nuget">nuget page</a>.

* Create a new **class library** project 

## Get the Nuget packages

In the <a href="http://docs.nuget.org/docs/start-here/using-the-package-manager-console">Package Manger Console</a> run the following command to install the fluent ribbon for Excel-DNA. It will also install Excel-DNA for you.

You will need to get **NetOffice** as we are using it instead of **Office.Interop.Excel** to manipulate the Excel application.


{% highlight yaml %}
PM> Install-Package AddinX.Core.ExcelDna
PM> Install-Package NetOffice.Excel -Version 1.7.3
{% endhighlight %}





