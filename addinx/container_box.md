---
title: Box
tags: [fluent_ribbon]
keywords: box, control, ribbon,  
audience: everyone
summary: "We will see what is a Box and how to use it." 
series: "Fluent ribbon"
weight: 1
---

## Box

**Definition**: A box is a container used to arrange controls within a group. The controls part of a box can be display either vertically or horizontally. 

For example, consider a group of controls that are laid out horizontally, as follows:

![example of a box container](images/control_box.png)

### How to create it?

This layout is specified using the following code
{% highlight dotnet %}
	.Items(d =>
	{
	    d.AddBox().SetId("box")
	        .HorizontalDisplay()
	        .AddItems(i =>
	        {  
	            i.AddButton("Button 1")
	            	.SetId("button1")
	                .NormalSize()
	                .ImageMso("HappyFace");

	            i.AddButton("Button 2")
	               .SetId("button2")
	               .NormalSize()
	               .ImageMso("HappyFace");
	        });
	});
{% endhighlight %}

### Events

It is possible to apply the following events to a box

*	*Visible*: The condition requires to show the box container

### Children

It is below controls can be added to a box

*	Box, Button, Checkbox, Combo-box, Dropdown, Menu, Gallery, Edit box, Label, Toggle button
