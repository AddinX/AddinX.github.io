---
title: Dialogbox launcher control
tags: [fluent_ribbon,control]
keywords: dialogbox, control, ribbon,  
audience: everyone
summary: "We will see what is a dialog-box launcher and how to use it." 
series: "Control"
weight: 1
---

## Dialog-box launcher

**Definition**: A dialog box launcher is a control at the *group* level that act like a button. 
 
For example, consider a dialog-box launcher control, as follows:

![dialog-box example](images/control_dialogbox.png)

### How to create it?

This is specified using the following code

{% highlight dotnet %}
	g.AddGroup("Custom Group")
	    .SetId("CustomGroupId")
	    .Items(d =>
	    {
	        ...
	    })
	    .DialogBoxLauncher(i => 
	    	i.AddDialogBoxLauncher()
	           .SetId("dialogboxId")
	           .Screentip("Dialog Box Launcher"));

{% endhighlight %}

### Events

It is possible to apply the following events to a button

*	*Visible*: The condition requires to show the control
*	*Enable*: The condition requires to enable the control
*	*Action*: Define the action that will be done when the control is clicked

**Example**

* When the user click on the dialog box launcher, a message box is displayed saying "Dialog Box clicked"

{% highlight dotnet %}
    protected override void CreateRibbonCommand(IRibbonCommands cmds)
    {
        cmds.AddDialogBoxLauncherCommand("dialogboxId")
            .Action(() => MessageBox.Show("Dialog Box clicked"));
    }
{% endhighlight %}