---
title: Menu control
tags: [fluent_ribbon,control]
keywords: menu, control, ribbon,  
audience: everyone
summary: "We will see what is a menu and how to use it." 
series: "Control"
weight: 1
---

## Menu

**Definition**: A menu displays a list of commands and can be compose of sub-menu.
 
For example, consider a menu control, as follows:

![menu example](images/control_menu.png)

### How to create it?

This is specified using the following code:

{% highlight dotnet %}
       .Items(d =>
       {
           d.AddMenu("Menu")
               .SetId("menuId").ShowLabel()
               .ImageMso("HappyFace").NormalSize()
               .ItemNormalSize().AddItems(v =>
               {
                   v.AddButton("Button 1")
                       .SetId("button1Id")
                       .ImageMso("FileSave");

                   v.AddButton("Button 2")
                       .SetId("button2Id")
                       .ImageMso("Bold");

                   v.AddButton("Button 3")
                       .SetId("button3Id")
                       .ImageMso("Undo");
               });

       });
{% endhighlight %}

### Events

It is possible to apply the following events to a menu

*	*Visible*: The condition requires to show the control
*	*Enable*: The condition requires to enable the control

### Children

The following controls can be attached to a menu

*	Button, checkbox, menu, gallery, toggle button. 
