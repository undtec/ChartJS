#tag WebPage
Begin WebPage WebPage1
   AllowTabOrderWrap=   True
   Compatibility   =   ""
   ControlID       =   ""
   Enabled         =   False
   Height          =   768
   ImplicitInstance=   True
   Index           =   -2147483648
   Indicator       =   0
   IsImplicitInstance=   False
   LayoutDirection =   0
   LayoutType      =   0
   Left            =   0
   LockBottom      =   False
   LockHorizontal  =   False
   LockLeft        =   True
   LockRight       =   False
   LockTop         =   True
   LockVertical    =   False
   MinimumHeight   =   768
   MinimumWidth    =   1024
   TabIndex        =   0
   Title           =   "Untitled"
   Top             =   0
   Visible         =   True
   Width           =   1024
   _ImplicitInstance=   False
   _mDesignHeight  =   0
   _mDesignWidth   =   0
   _mName          =   ""
   _mPanelIndex    =   -1
   Begin ChartJS MyChart
      ChartType       =   0
      ControlID       =   ""
      Enabled         =   True
      Height          =   568
      Index           =   -2147483648
      Indicator       =   0
      Left            =   188
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Scope           =   0
      TabIndex        =   0
      Tooltip         =   ""
      Top             =   38
      Visible         =   True
      Width           =   796
      _mPanelIndex    =   -1
   End
   Begin WebButton Bar
      AllowAutoDisable=   False
      Cancel          =   False
      Caption         =   "Bar"
      ControlID       =   ""
      Default         =   False
      Enabled         =   True
      Height          =   38
      Index           =   -2147483648
      Indicator       =   0
      Left            =   31
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Scope           =   0
      TabIndex        =   1
      Tooltip         =   ""
      Top             =   60
      Visible         =   True
      Width           =   100
      _mPanelIndex    =   -1
   End
   Begin WebButton Bar2
      AllowAutoDisable=   False
      Cancel          =   False
      Caption         =   "Bar 2"
      ControlID       =   ""
      Default         =   False
      Enabled         =   True
      Height          =   38
      Index           =   -2147483648
      Indicator       =   0
      Left            =   31
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Scope           =   0
      TabIndex        =   2
      Tooltip         =   ""
      Top             =   106
      Visible         =   True
      Width           =   100
      _mPanelIndex    =   -1
   End
   Begin WebButton Stacked
      AllowAutoDisable=   False
      Cancel          =   False
      Caption         =   "Stacked"
      ControlID       =   ""
      Default         =   False
      Enabled         =   True
      Height          =   38
      Index           =   -2147483648
      Indicator       =   0
      Left            =   31
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Scope           =   0
      TabIndex        =   3
      Tooltip         =   ""
      Top             =   152
      Visible         =   True
      Width           =   100
      _mPanelIndex    =   -1
   End
End
#tag EndWebPage

#tag WindowCode
#tag EndWindowCode

#tag Events MyChart
	#tag Event
		Sub Opening()
		  MyChart.NewCleanChart
		  //define chart type
		  Me.ChartType = ChartJS.ChartTypes.Line
		  //define labels
		  Me.AddLabels("January", "February", "March", "April", "May", "June", "July")
		  //define first dataset
		  Var ds As New Dictionary
		  ds.Value("label") = "Dataset 1"
		  ds.Value("data") = Array(10, 30, 50, 20, 25, 44, -10)
		  ds.Value("borderColor") = ChartJS.RGBAColor(Color.Red)
		  ds.Value("backgroundColor") = ChartJS.RGBAColor(Color.Red)
		  Me.AddDataset(ds) //add dataset
		  ds = New Dictionary
		  //define second dataset
		  ds.Value("label") = "Dataset 2"
		  ds.Value("data") = Array("ON", "ON", "OFF", "ON", "OFF", "OFF", "ON")
		  ds.Value("borderColor") = ChartJS.RGBAColor(Color.Blue)
		  ds.Value("backgroundColor") = ChartJS.RGBAColor(Color.Blue)
		  ds.Value("stepped") = "True" //make it stepped
		  ds.Value("yAxisID") = "y2"
		  Me.AddDataset(ds) //add dataset
		  
		  //set the options (no need for OverrideOptions)
		  Me.Options.Value("responsive") = True
		  //set title
		  Var Title As New Dictionary
		  Var Plugins As New Dictionary
		  Title.Value("display") = True
		  Title.Value("text") = "Stacked scales"
		  Plugins.Value("title") = Title
		  Me.Options.Value("plugins") = Plugins
		  
		  //define scales
		  Var Scales As New Dictionary
		  Var y As New Dictionary
		  Var yGrid As New Dictionary
		  
		  //define first y (line chart not stepped)
		  yGrid.Value("borderColor") = ChartJS.RGBAColor(Color.Red)
		  y.Value("type") = "linear"
		  y.Value("position") = "left"
		  y.Value("stack") = "demo"
		  y.Value("stackWeight") = 2
		  y.Value("grid") = yGrid
		  Scales.Value("y") = y
		  
		  //define second y
		  Var y2 As New Dictionary
		  y2.Value("type") = "category" //override type to category
		  y2.Value("labels") = Array("ON", "OFF") //we can use ON/OFF because is category
		  y2.Value("offset") = True
		  y2.Value("position") = "left"
		  y2.Value("stack") = "demo"
		  y2.Value("stackWeight") = 1
		  Var y2Grid As New Dictionary
		  y2Grid.Value("borderColor") = ChartJS.RGBAColor(Color.Blue)
		  y2.Value("grid") = y2Grid
		  Scales.Value("y2") = y2
		  //assign the scales to Options
		  Me.Options.Value("scales") = Scales
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Bar
	#tag Event
		Sub Pressed()
		  MyChart.NewCleanChart
		  
		  Var ds As New Dictionary
		  ds.Value("label") = "Hello, World!"
		  ds.Value("data") = Array(345890, 421934, 456908, 567987)
		  ds.Value("backgroundColor") = ChartJS.RGBAColor(Color.Orange)
		  
		  MyChart.ChartType = ChartJS.ChartTypes.Bar
		  MyChart.AddDataset(ds)
		  MyChart.AddLabels("Q1", "Q2", "Q3", "Q4")
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Bar2
	#tag Event
		Sub Pressed()
		  MyChart.NewCleanChart
		  
		  MyChart.ChartType = ChartJS.ChartTypes.Bar
		  MyChart.AddLabels("Red", "Blue", "Yellow", "Green", "Purple", "Orange")
		  
		  Var ds As New Dictionary
		  ds.Value("label") = "# of Votes"
		  ds.Value("data") = Array(12, 19, 3, 5, 2, 3)
		  ds.Value("backgroundColor") = Array(ChartJS.RGBAColor(Color.RGB(255, 99, 132, 204)), _
		  ChartJS.RGBAColor(Color.RGB(54, 162, 235, 204)), _
		  ChartJS.RGBAColor(Color.RGB(255, 206, 86, 204)), _
		  ChartJS.RGBAColor(Color.RGB(75, 192, 192, 204)), _
		  ChartJS.RGBAColor(Color.RGB(153, 102, 255, 204)), _
		  ChartJS.RGBAColor(Color.RGB(255, 159, 64, 204)))
		  ds.Value("borderColor") = Array(ChartJS.RGBAColor(Color.RGB(255, 99, 132)), _
		  ChartJS.RGBAColor(Color.RGB(54, 162, 235)), _
		  ChartJS.RGBAColor(Color.RGB(255, 206, 86)), _
		  ChartJS.RGBAColor(Color.RGB(75, 192, 192)), _
		  ChartJS.RGBAColor(Color.RGB(153, 102, 255)), _
		  ChartJS.RGBAColor(Color.RGB(255, 159, 64)))
		  ds.Value("borderWidth") = 1
		  
		  MyChart.AddDataset(ds)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Stacked
	#tag Event
		Sub Pressed()
		  MyChart.NewCleanChart
		  
		  //define chart type
		  MyChart.ChartType = ChartJS.ChartTypes.Line
		  //define labels
		  MyChart.AddLabels("January", "February", "March", "April", "May", "June", "July")
		  //define first dataset
		  Var ds As New Dictionary
		  ds.Value("label") = "Dataset 1"
		  ds.Value("data") = Array(10, 30, 50, 20, 25, 44, -10)
		  ds.Value("borderColor") = ChartJS.RGBAColor(Color.Red)
		  ds.Value("backgroundColor") = ChartJS.RGBAColor(Color.Red)
		  MyChart.AddDataset(ds) //add dataset
		  ds = New Dictionary
		  //define second dataset
		  ds.Value("label") = "Dataset 2"
		  ds.Value("data") = Array("ON", "ON", "OFF", "ON", "OFF", "OFF", "ON")
		  ds.Value("borderColor") = ChartJS.RGBAColor(Color.Blue)
		  ds.Value("backgroundColor") = ChartJS.RGBAColor(Color.Blue)
		  ds.Value("stepped") = "True" //make it stepped
		  ds.Value("yAxisID") = "y2"
		  MyChart.AddDataset(ds) //add dataset
		  
		  //set the options (no need for OverrideOptions)
		  MyChart.Options.Value("responsive") = True
		  //set title
		  Var Title As New Dictionary
		  Var Plugins As New Dictionary
		  Title.Value("display") = True
		  Title.Value("text") = "Stacked scales"
		  Plugins.Value("title") = Title
		  MyChart.Options.Value("plugins") = Plugins
		  
		  //define scales
		  Var Scales As New Dictionary
		  Var y As New Dictionary
		  Var yGrid As New Dictionary
		  
		  //define first y (line chart not stepped)
		  yGrid.Value("borderColor") = ChartJS.RGBAColor(Color.Red)
		  y.Value("type") = "linear"
		  y.Value("position") = "left"
		  y.Value("stack") = "demo"
		  y.Value("stackWeight") = 2
		  y.Value("grid") = yGrid
		  Scales.Value("y") = y
		  
		  //define second y
		  Var y2 As New Dictionary
		  y2.Value("type") = "category" //override type to category
		  y2.Value("labels") = Array("ON", "OFF") //we can use ON/OFF because is category
		  y2.Value("offset") = True
		  y2.Value("position") = "left"
		  y2.Value("stack") = "demo"
		  y2.Value("stackWeight") = 1
		  Var y2Grid As New Dictionary
		  y2Grid.Value("borderColor") = ChartJS.RGBAColor(Color.Blue)
		  y2.Value("grid") = y2Grid
		  Scales.Value("y2") = y2
		  //assign the scales to Options
		  MyChart.Options.Value("scales") = Scales
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="_mPanelIndex"
		Visible=false
		Group="Behavior"
		InitialValue="-1"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Index"
		Visible=true
		Group="ID"
		InitialValue="-2147483648"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Left"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Top"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ControlID"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Enabled"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Behavior"
		InitialValue="400"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LayoutType"
		Visible=true
		Group="Behavior"
		InitialValue="LayoutTypes.Fixed"
		Type="LayoutTypes"
		EditorType="Enum"
		#tag EnumValues
			"0 - Fixed"
			"1 - Flex"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockHorizontal"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockVertical"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=true
		Group="Behavior"
		InitialValue="400"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumWidth"
		Visible=true
		Group="Behavior"
		InitialValue="600"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Behavior"
		InitialValue="Untitled"
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=false
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Behavior"
		InitialValue="600"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="_ImplicitInstance"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="_mDesignHeight"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="_mDesignWidth"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="_mName"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="IsImplicitInstance"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowTabOrderWrap"
		Visible=false
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabIndex"
		Visible=true
		Group="Visual Controls"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Indicator"
		Visible=false
		Group="Visual Controls"
		InitialValue=""
		Type="WebUIControl.Indicators"
		EditorType="Enum"
		#tag EnumValues
			"0 - Default"
			"1 - Primary"
			"2 - Secondary"
			"3 - Success"
			"4 - Danger"
			"5 - Warning"
			"6 - Info"
			"7 - Light"
			"8 - Dark"
			"9 - Link"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="LayoutDirection"
		Visible=true
		Group="WebView"
		InitialValue="LayoutDirections.LeftToRight"
		Type="LayoutDirections"
		EditorType="Enum"
		#tag EnumValues
			"0 - LeftToRight"
			"1 - RightToLeft"
			"2 - TopToBottom"
			"3 - BottomToTop"
		#tag EndEnumValues
	#tag EndViewProperty
#tag EndViewBehavior
