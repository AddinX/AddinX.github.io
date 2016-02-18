---
title: Why using ExcelDNA and NetOffice
tags: [getting_started]
keywords:  start, NetOffice, ExcelDNA, VSTO, Add-in 
audience: everyone
summary: "Why do we choose those 3rd parties libraries for Excel ?" 
weight: 1
---

## Why using NetOffice and not Office.Interop.Excel ?

The usual methods for accessing Microsoft Office. NET is the Primary Interop Assemblies. This access method involves various disadvantages.

*	It is limited to a version, i.e. it only works with one or certain versions of Office
*	it offers no protection mechanism in the management of COM proxies

NetOffice eliminates these disadvantages and remains a 1:1 wrapper that is syntactically and semantically identical to the interop assemblies.  

With Primary Interop Assemblies, Office is based on a COM-architecture. That means that you retrieve COM proxy objects in your application and they need to be disposed manually. If the COM objects are not released then the COM server has to keep the object in memory, even after closing the application. It generates a memory leak and the instance created would still be visible as active process in the Windows Task Manager. 

In NetOffice you do not have to free such objects explictly, you may use them implicitly. NetOffice remove them for you as NetOffice store all created COM Proxies in a COM proxy table including the information through which object a proxy was created.

## Why are we using Excel-DNA and not VSTO

Excel-DNA is an independent project to integrate .NET into Excel. With Excel-DNA you can make native (.xll) add-ins for Excel, providing high-performance user-defined functions (UDFs), custom ribbon interfaces and more.

VSTO is a great tool and helps to create robust add-in nevertheless it doesn’t provide the possibility to create user-defined function. This functionality is important and Excel-DNA is the only one to provide it. 
