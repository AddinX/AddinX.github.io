---
title: Using a WCF service in an add-in
tags: [example]
keywords: example,excedna, excel-dna,WCF, addin, add-in, 
audience: everyone
summary: "We will present how easy it is to consume data from a WCF service in an Excel add-in." 
series: "example"
weight: 1
---



**Objective**: Pass a name to a WCF service and get a message saying “Hi name”. This service has been created with the only purpose of illustrate the concept of calling a WCF service from an add-in.

*	The service is hosted on appharbor: [http://addinxwcfsample.apphb.com/SayHelloService.svc](http://addinxwcfsample.apphb.com/SayHelloService.svc)
*	The source code of the service can be found here: [https://github.com/AmaelN/sample.wcf](https://github.com/AmaelN/sample.wcf)

We are using the following AddinX packages:

*	**AddinX.Bootstrap**: Using the extension for Autofac to register WCF service
*	**AddinX.Configuration**: read the appSetting to get the url to the service
*	**AddinX.Ribbon**: Create a tab with buttons to call the WCF service

**Nuget command**

{% highlight dotnet %}
Install-Package AddinX.Ribbon.ExcelDna
Install-Package AddinX.Configuration.Implementation 
Install-Package AddinX.Bootstrap.Autofac
{% endhighlight %}

We will explain the part related to the WCF service, we assume that you are using the packages listed above. You can also download [the sample](https://github.com/AddinX/Sample.Wcf) from github or use the following command line.

{% highlight dotnet %}
git clone https://github.com/AddinX/Sample.Wcf.git
{% endhighlight %}

### Application setting for the service URL

In the application configuration file named *“WcfSample-AddIn.xll.config”*, we included a appSetting named **SayHelloServiceUri** with value set to the URL of the WCF service.

{% highlight dotnet %}
  <appSettings>
    <add key="SayHelloServiceUri" value="http://addinxwcfsample.apphb.com/SayHelloService.svc"/>
  </appSettings>
{% endhighlight %}

### Registration of the WCF Service

In the package AddinX.Bootstrap.Autofac, we created an extension to allow the registration of WCF service with the *ContainerBuilder* from **Autofac**. 

The code of this extension is as follow:

{% highlight dotnet %}
        public static void RegisterWcfService<T>(this ContainerBuilder builder, string serviceUri)
        {
            builder.Register(c => new ChannelFactory<T>(new BasicHttpBinding(),
                new EndpointAddress(serviceUri))).SingleInstance();
            builder.Register(c => c.Resolve<ChannelFactory<T>>().CreateChannel()).As<T>();
        }
{% endhighlight %}

We used the code provided on the [Autofac documentation](http://docs.autofac.org/en/latest/integration/wcf.html?highlight=wcf#clients) for Clients and made it generic so we only have to pass the Interface of the service and the URL to the WCF service.

If we want to register a WCF service with Autofac, we need to write only one line of code:

{% highlight dotnet %}
var serviceUri = AddinContext.ConfigManager.AppSettings["SayHelloServiceUri"];
bootstrapper.Builder.RegisterWcfService<ISayHelloService>(serviceUri);
{% endhighlight %}

### Consume the service

To use the service, it will be injected by Autofac in classes that have the service interface as input parameter to their constructor.

{% highlight dotnet %}
private ISayHelloService service;
public MainController(ISayHelloService service)
{
	this.service = service;
}
{% endhighlight %}

That’s it! Now you just need to consume the service as the example below

{% highlight dotnet %}
public async void SayHello(string name)
{   
	var request = new SayHelloRequest {Name = name};

	await Task.Run(() =>
	{
		var response = service.SayHello(request);
		MessageBox.Show(response.HelloMessage);
	}
	,AddinContext.TokenCancellationSource.Token);
}
{% endhighlight %}
