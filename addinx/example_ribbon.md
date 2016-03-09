---
title: Fluent ribbon sample
tags: [example]
keywords: example,excedna, excel-dna,ribbon,fluent, addin, add-in, 
audience: everyone
summary: "Using the Add-in X toolkit, it is easy to create a ribbon." 
series: "example"
weight: 1
---

We are using the following AddinX packages:

*	**AddinX.Ribbon**: Create a tab with all the controls

**Nuget command**

{% highlight dotnet %}
Install-Package AddinX.Ribbon.ExcelDna
{% endhighlight %}

You can download [the sample](https://github.com/AddinX/Sample.Ribbon) from github or use the following command line.

{% highlight dotnet %}
git clone https://github.com/AddinX/Sample.Ribbon.git
{% endhighlight %}

With this sample, you will be able see how we created all the controls using the Add-in X library.

## Program class (the entry point)

The class program is the entry point of the add-in as it is thanks to this class that Excel-DNA can register the add-in to Excel. It can be only one class that derive from ** IExcelAddIn** in an add-in. 
This is where you can instantiate objects that you want to keep during the life cycle of the add-in. If you are using an Inversion of Control container, this is where you can start it. 
In the present example, we will only keep a reference to the Excel application.

{% highlight dotnet %}
public class Program : IExcelAddIn
    {
        public void AutoOpen()
        {
            try
            {   
                // The Excel Application object
                AddinContext.ExcelApp = new Application(null, ExcelDnaUtil.Application);
            }
            catch (Exception e)
            {
                LogDisplay.RecordLine(e.Message);
                LogDisplay.RecordLine(e.StackTrace);
                LogDisplay.Show();
            }
        }
 
        public void AutoClose()
        {
            throw new NotImplementedException();
        }
    }

{% endhighlight %}

{{site.data.alerts.note}}
<b>Note:</b> The *AutoClose* method is never called during the like cycle of an add-in.
{{site.data.alerts.end}}

## The ribbon class

Create a new class named ***Ribbon*** and it needs to be inheriting from  ***RibbonFluent*** (AddinX.Ribbon.ExcelDna).
This class must be **ComVisible** in order for Excel-DNA to use it.

The following inherited methods will be created:

* **CreateFluentRibbon** : This is where you will define the UI part of the ribbon.
* **CreateRibbonCommand** : This is where you will define the callbacks methods for the controls using the control's unique identifier.
* **OnClosing** : This is where you can dispose objects from the **AddinContext** class before Excel closes.
* **OnOpening** : This method is mainly used to listen to Excel's events

{% highlight dotnet %}
    [ComVisible(true)]
    public class Ribbon : RibbonFluent
    {
        protected override void CreateFluentRibbon(IRibbonBuilder build)
        {
        }

        protected override void CreateRibbonCommand(IRibbonCommands cmds)
        {
        }

        public override void OnClosing()
        {
        }

        public override void OnOpening()
        {
        }
    }
{% endhighlight %}
{{site.data.alerts.note}}
<b>Note:</b> Don't forget to set the class <b>ComVisible = true</b>
{{site.data.alerts.end}}


Please refer to the documentation on the **ribbon builder** and **controls** to fill the methods presented above.