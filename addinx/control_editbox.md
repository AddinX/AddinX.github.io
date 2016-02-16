---
title: edit box control
tags: [fluent_ribbon,control]
keywords: editbox, control, ribbon,  
audience: everyone
summary: "We will see what is a edit box and how to use it." 
series: "Control"
weight: 1
---

## Edit box

**Definition**: A edit box allows the user to input text.
 
For example, consider an edit box control, as follows:

![edit box example](images/control_editbox.png)

### How to create it?

{% highlight dotnet %}
	.Items(d =>
	{
		d.AddEditbox("Edit Box")
		    .SetId("editBoxId");
	});
{% endhighlight %}

### Events

It is possible to apply the following events to an edit box

*	*Visible*: The condition requires to show the control
*	*Enable*: The condition requires to enable the control
*	*OnChange*: Define the action that will be done when the content of the control is changed
*	*GetText*: Define the initial text of the control


 **Example**

how the events *OnChange* and *GetText* can be used for the edit-box below:

{% highlight dotnet %}

    private string editboxValue;

    protected override void CreateRibbonCommand(IRibbonCommands cmds)
    {
        cmds.AddEditBoxCommand("editBoxId")
            .OnChange(newValue =>
            {
                editboxValue = newValue;
                // You can invalidate a specific control here
                //example:  Ribbon.InvalidateControl("labelControlId");
            })
            .GetText(() => "Text");

        //// Example with a control using the editboxValue:
        // cmds.AddLabelCommand("labelControlId")
        //    .GetLabel(() => editboxValue);
    }
{% endhighlight %}