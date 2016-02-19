---
title: Unique Identifier
tags: [fluent_ribbon]
keywords: id, control, ribbon, identifier, 
audience: everyone
summary: "There is 3 different type of identifier that you can use. We will present them here." 
series: "Fluent ribbon"
weight: 1
---

## Control unique identifier

* It is mandatory to include an identifier to each control and each identifier must be unique. There is three different type of identifier that can be used to reference a control.

The “Standard” identifier is a string of character which is unique and can be used to reference the control. The scope of the identifier is limited to the current add-in / ribbon.

{% highlight dotnet %}
	.Items(d =>
	{
	    d.AddButton("Button").SetId("buttonId")	       
	});
{% endhighlight %}

* The "Microsoft" identifier, it used when we wish to use built-in control (that has been created by Microsoft). An example, we could add the save button and it functionality to our custom tab by creating a button with the following **IdMso** : *"FileSave"*.

{% highlight dotnet %}
	.Items(d =>
	{
	    d.AddButton("Save File").SetIdMso("FileSave")
         .NormalSize().ImageMso("FileSave");	       
	});
{% endhighlight %}

* The "Namespace" identifier (aka qualified identifier) allows us to increase the scope of the identifier. Meaning, if we have one add-ins that used a namespace identifier for the **tabs** or **groups**, it will be possible to create a second add-in that will extend the functionalities available in the namespace of the **tab** or **group**. In other terms, two different add-ins can add to the same custom tab/group as long they refer to that custom tab/group by its qualified identifier.

{% highlight dotnet %}
builder.CustomUi.AddNamespace("acme", "acme.addin.sync").Ribbon.Tabs(c =>
{
    c.AddTab("My Tab").SetIdQ("acme", MyTabId)
        .Groups(g =>
        {
            g.AddGroup("Data").SetIdQ("acme", DataGroupId)
                .Items(d => { ... });
        });
 }
{% endhighlight %}