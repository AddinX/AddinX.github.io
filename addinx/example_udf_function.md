---
title: Creating an add-in for Excel functions
tags: [example]
keywords: example,excedna, excel-dna,udf, user-defined, function, 
audience: everyone
summary: "It is the simplest functionality and we will see how to do so." 
series: "example"
weight: 1
---


**Objective:** Create an add-in to include new excel functions.

We are using the following packages:

*	**ExcelDna.AddIn**: Excel-DNA library which is mandatory to create user-defined functions and macros in Excel.
*	**NetOffice.Excel**: Wrapper to access MS Office Excel application.

**Nuget command**

{% highlight dotnet %}
Install-Package ExcelDna.AddIn
Install-Package NetOffice.Excel -Version 1.7.3
{% endhighlight %}

We will explain how to create an add-in to add extra user-defined function to Excel. We assume that you are using the packages listed above. You can also download [the sample](https://github.com/AddinX/Sample.Addins) from github or use the following command line.

{% highlight dotnet %}
git clone https://github.com/AddinX/Sample.Addins.git
{% endhighlight %}

### Program class (entry point)

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
<b>Note:</b> The *AutoClose* method is never called during the life cycle of an add-in.
{{site.data.alerts.end}}

### The user-defined functions (udf)

We store the new user-defined function in a folder named **Function** for simplicity. We included 2 examples provided by Excel-DNA. For more information on how to create user-defined function, we recommend you to look at the following Excel-DNA documentation on [how to create your first C# add-in](http://www.codeplex.com/Download?ProjectName=exceldna&DownloadId=372242).
From a user-defined function you can retrieve information from a database, a web service or do calculation to display a value or an array of data.
