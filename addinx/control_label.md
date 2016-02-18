---
title: Label control
tags: [fluent_ribbon,control]
keywords: label, control, ribbon,  
audience: everyone
summary: "We will see what is a label and how to use it." 
series: "Control"
weight: 1
---

## Label Control

**Definition**: It represent a label. It can be used if we want to display a specific text in the ribbon to notify the user about something.
 
For example, consider an label control, as follows:

![label control example](images/control_label.png)

### How to create it?

This is specified using the following code:

{% highlight dotnet %}
	.Items(d =>
	{
		d.AddLabelControl()
		    .SetId("labelId");
	});
{% endhighlight %}

The label is defined dynamically using the *GetLabel* event (See below).

### Events

It is possible to apply the following events to a label

*	*Visible*: The condition requires to show the control
*	*Enable*: The condition requires to enable the control
*	*GetLabel*: Define the text that will be display. It can be changed dynamically 

{% highlight dotnet %}
	protected override void CreateRibbonCommand(IRibbonCommands cmds)
	{
		cmds.AddLabelCommand("labelId")
		     .GetLabel(() => "Label Control");
	}
{% endhighlight %}
