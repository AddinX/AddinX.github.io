---
title: Using a WPF application in an add-in
tags: [example]
keywords: example,excedna, excel-dna,WPF, addin, add-in, 
audience: everyone
summary: "Opening a WPF window from an Excel add-in is now made easy using our helper method." 
series: "example"
weight: 1
---

**Objective:** Open a WPF wizard from an Excel add-in and exchange data between Excel and the WPF window.

We are using the following AddinX packages:

*	**AddinX.Bootstrap**: Register the WPF classes so the WPF window can be resolve without having to instantiate manually any dependency.
*	**AddinX.WPF**: Provide a helper method to open a WPF window from within an Excel-DNA add-in.
*	**AddinX.Ribbon**: Create a tab with buttons to call the WPF application

**Nuget command**

{% highlight dotnet %}
Install-Package AddinX.Ribbon.ExcelDna
Install-Package AddinX.Wpf.Implementation
Install-Package AddinX.Bootstrap.Autofac
{% endhighlight %}

We will explain the part related to the WPF application, we assume that you are using the packages listed above. You can also download [the sample](https://github.com/AddinX/Sample.Wpf) from github or use the following command line.

{% highlight dotnet %}
git clone https://github.com/AddinX/Sample.Wpf.git
{% endhighlight %}

### Registration of the WCF class with the Inversion of Control container Autofac

If we want **Autofac** to be able to resolve the *MainWindow* from the WPF application, it is required to register all the WPF classes. It is done during the startup process of the Bootstrap.

{% highlight dotnet %}
        public void Execute(IRunnerMain bootstrap)
        {
            var bootstrapper = (Bootstrapper)bootstrap;
 
            bootstrapper?.Builder.RegisterType<MainWindow>();
            bootstrapper?.Builder.RegisterType<MainWindowViewModel>();
 
            bootstrapper?.Builder.RegisterType<MeetingWizardContainerViewModel>();
            bootstrapper?.Builder.RegisterType<MeetingWizardContainerView>();
 
            bootstrapper?.Builder.RegisterType<MeetingController>();
            
            bootstrapper?.Builder.RegisterType<MeetingWizardFirstView>();
            bootstrapper?.Builder.RegisterType<MeetingWizardSecondView>();
            bootstrapper?.Builder.RegisterType<MeetingWizardLastView>();
            
            bootstrapper?.Builder.RegisterType<MeetingWizardFirstViewModel>();
            bootstrapper?.Builder.RegisterType<MeetingWizardSecondViewModel>();
            bootstrapper?.Builder.RegisterType<MeetingWizardLastViewModel>();
        }
{% endhighlight %}

### Opening the WPF window

In the package AddinX.WPF, an helper class has been recreated to ease the process of opening of a WPF. Let consider that this form will be manage by a controller that receive as a parameter an *IWpfHelper* . Let’s call this controller *“SampleController”*.

{% highlight dotnet %}
        private readonly ILogger logger;
        private IWpfHelper wpfHelper;
 
        public SampleController(ILogger logger, IWpfHelper wpfHelper)
        {
            this.logger = logger;
            this.wpfHelper = wpfHelper;
        }
{% endhighlight %}

The Inversion of Controls (IoC) container will resolve the dependency and inject the correct object when the controller will be instantiated as the *WpfHelper* class has been register to the IoC container.

{% highlight dotnet %}
bootstrapper?.Builder.RegisterType<ExcelDnaWpfHelper>().As<IWpfHelper>();
{% endhighlight %}

The code associated with the opening of the WPF form is the following in the controller *“SampleController”*:

{% highlight dotnet %}
        public void OpenForm()
        {
            logger.Debug("Inside show message method");
            var window = AddinContext.Container.Resolve<MainWindow>();
            wpfHelper.Show(window);
        }
{% endhighlight %}

It is easy to link a button on the ribbon to call this method when clicked in the method *CreateRibbonCommand* of the class **AddinRibbon**:

{% highlight dotnet %}
       cmds.AddButtonCommand("MeetingIdCmd")            
               .Action(() => AddinContext.MainController.Sample.OpenForm());
{% endhighlight %}

### Interaction between the WPF application and Excel

The interaction between the WPF application and Excel is possible as long they are sharing a communication channel like the *events aggregator* from **Prism**. This way the WPF application will be able to publish message and Excel will subscribe to them and return the appropriate response message.

In the sample, a controller has been created to manage the interaction with the WPF application: *WpfInteractionController*.  This controller receives an instance of the IEventAggragtor and subscribe to specific events in its constructor 

{% highlight dotnet %}
        public WpfInteractionController(IEventAggregator eventAgg,
            ExcelInteraction excelOperation,
            ILogger logger)
        {
            this.eventAgg = eventAgg;
            this.excelOperation = excelOperation;
            this.logger = logger;
 
            tokenMeetingData = eventAgg.GetEvent<PubSubEvent<ExcelMeetingDataRequest>>()
                .Subscribe(WriteMeetingData);
 
            tokenSheetName = eventAgg.GetEvent<PubSubEvent<ExcelWorksheetNamesRequest>>()
                .Subscribe(GetWorksheetsName);
        }
{% endhighlight %}

The token associated to each subscription is kept as it is important to unsubscribe from them when the controller is disposed to avoid memory leak.
Let’s look at the subscription to the second subscription which is regarding the name of the sheets of the current workbook. The information returned by Excel are used to populate the ***sheet destination*** combo-box of the WPF wizard.
The method *GetWorksheetsName* is as follow:

{% highlight dotnet %}
        private void GetWorksheetsName(ExcelWorksheetNamesRequest obj)
        {
            logger.Debug("Return excel sheets names");
 
            var response = new ExcelWorksheetNamesResponse
            {
                SheetNames = excelOperation.WorksheetsName().ToArray(),
            };
 
            eventAgg.GetEvent<PubSubEvent<ExcelWorksheetNamesResponse>>()
                .Publish(response);
        }

{% endhighlight %}

The code for the *excelOperation.WorksheetsName()* method is the following:

{% highlight dotnet %}
        public IList<string> WorksheetsName()
        {
            if (excelApp?.Sheets == null)
            {
                return new List<string>();
            }
            return excelApp.Sheets
                .Select(sheet => ((Worksheet) sheet).Name)
                .ToList();
        }

{% endhighlight %}

### The request sent by the WPF application

For the current example regarding the worksheets name, the request is made from the constructor of the view model that need that information.

{% highlight dotnet %}
        public MeetingWizardSecondViewModel(IEventAggregator eventAggregator)
        {
            this.eventAggregator = eventAggregator;
 
            // register to the Excel response for the Worksheets name
            worksheetNamesToken = eventAggregator
                .GetEvent<PubSubEvent<ExcelWorksheetNamesResponse>>()
                .Subscribe(GetListWorksheetFromExcel);
 
            // Send the request to Excel regarding the worksheets name
            eventAggregator.GetEvent<PubSubEvent<ExcelWorksheetNamesRequest>>()
                .Publish(new ExcelWorksheetNamesRequest());
 
            …
        }
{% endhighlight %}


