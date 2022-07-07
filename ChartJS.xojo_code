#tag Class
Protected Class ChartJS
Inherits WebSDKUIControl
	#tag Event
		Function JavaScriptClassName() As String
		  Return "ChartJS.ChartJSControl"
		End Function
	#tag EndEvent

	#tag Event
		Sub Opening()
		  Options = New Dictionary
		  Opening
		End Sub
	#tag EndEvent

	#tag Event
		Sub Serialize(js as JSONItem)
		  Var jsonDatasets As New JSONItem
		  For Each dataset As Dictionary In Datasets
		    jsonDatasets.Add(dataset)
		  Next dataset
		  
		  js.Value("type") = ChartTypeString
		  js.Value("datasets") = jsonDatasets
		  js.Value("labels") = Labels
		  js.Value("options") = Options
		End Sub
	#tag EndEvent

	#tag Event
		Function SessionCSSURLs(session as WebSession) As String()
		  If SharedCSSFile = Nil Then
		    SharedCSSFile = New WebFile
		    SharedCSSFile.Data = kCSS
		    SharedCSSFile.Filename = "ChartJSControl.css"
		    SharedCSSFile.MIMEType = "text/css"
		    SharedCSSFile.Session = Nil
		  End If
		  
		  Return Array(SharedCSSFile.URL)
		End Function
	#tag EndEvent

	#tag Event
		Function SessionJavascriptURLs(session as WebSession) As String()
		  If SharedJSFile = Nil Then
		    SharedJSFile = WebFile.Open(SpecialFolder.Resources.Child("ChartJSControl.js"))
		    
		    SharedJSFile = New WebFile
		    SharedJSFile.Data = kJS
		    SharedJSFile.Filename = "ChartJSControl.js"
		    SharedJSFile.MIMEType = "text/javascript"
		    SharedJSFile.Session = Nil
		  End If
		  
		  Return Array("https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.js", SharedJSFile.URL)
		End Function
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub AddDataset(dataset As Dictionary)
		  Datasets.Add(dataset)
		  UpdateControl
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddLabels(ParamArray labels() As String)
		  For Each label As String In labels
		    Self.Labels.Add(label)
		  Next label
		  UpdateControl
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ChartTypeString() As String
		  Select Case ChartType
		  Case ChartTypes.Area
		    Return "area"
		  Case ChartTypes.Bar
		    Return "bar"
		  Case ChartTypes.Bubble
		    Return "bubble"
		  Case ChartTypes.Doughnut
		    Return "doughnut"
		  Case ChartTypes.Line
		    Return "line"
		  Case ChartTypes.Mixed
		    Return ""
		  Case ChartTypes.PolarArea
		    Return "polarArea"
		  Case ChartTypes.Radar
		    Return "radar"
		  Case ChartTypes.Scatter
		    Return "scatter"
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function MapNumber(value As Double, low1 As Double, high1 As Double, low2 As Double, high2 As Double) As Double
		  Return low2 + (high2 - low2) * (value - low1) / (high1 - low1)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NewCleanChart()
		  Datasets.RemoveAll
		  Labels.RemoveAll
		  Options.RemoveAll
		  UpdateControl
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveDatasets()
		  Datasets.RemoveAll
		  UpdateControl
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveLabels()
		  Labels.RemoveAll
		  UpdateControl
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveOptions()
		  Options.RemoveAll
		  UpdateControl
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function RGBAColor(value As Color) As String
		  Var alpha As String = Str(MapNumber(value.Alpha, 0, 255, 1, 0))
		  Return "rgba(" + value.Red.ToString + ", " + value.Green.ToString + ", " + value.Blue.ToString + ", " + alpha + ")"
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Opening()
	#tag EndHook


	#tag Property, Flags = &h0
		ChartType As ChartTypes = ChartTypes.Line
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Datasets() As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Labels() As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Options As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared SharedCSSFile As WebFile
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared SharedJSFile As WebFile
	#tag EndProperty


	#tag Constant, Name = kCSS, Type = String, Dynamic = False, Default = \".ChartJSControl canvas {\n  max-width: 100% !important;\n  max-height: 100% !important;\n}", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kJS, Type = String, Dynamic = False, Default = \"\"use strict\";\nvar ChartJS;\n(function (ChartJS) {\n    class ChartJSControl extends XojoWeb.XojoVisualControl {\n        constructor(id\x2C events) {\n            super(id\x2C events);\n            this.mCanvas \x3D document.createElement(\"canvas\");\n            this.mChartType \x3D \"line\";\n            this.mLabels \x3D [];\n            this.mDatasets \x3D [];\n            this.mOptions \x3D \"\";\n            this.mChartInstance \x3D null;\n            const el \x3D this.DOMElement(\"\");\n            if (!el)\n                return;\n            el.append(this.mCanvas);\n        }\n        updateControl(data) {\n            var _a\x2C _b\x2C _c\x2C _d;\n            super.updateControl(data);\n            const json \x3D JSON.parse(data);\n            this.mChartType \x3D (_a \x3D json.type) !\x3D\x3D null && _a !\x3D\x3D void 0 \? _a : this.mChartType;\n            this.mLabels \x3D (_b \x3D json.labels) !\x3D\x3D null && _b !\x3D\x3D void 0 \? _b : this.mLabels;\n            this.mDatasets \x3D (_c \x3D json.datasets) !\x3D\x3D null && _c !\x3D\x3D void 0 \? _c : this.mDatasets;\n            this.mOptions \x3D (_d \x3D json.options) !\x3D\x3D null && _d !\x3D\x3D void 0 \? _d : this.mOptions;\n            this.refresh();\n        }\n        render() {\n            var _a;\n            super.render();\n            const el \x3D this.DOMElement(\'\');\n            if (!el)\n                return;\n            this.setAttributes(el);\n            (_a \x3D this.mChartInstance) \x3D\x3D\x3D null || _a \x3D\x3D\x3D void 0 \? void 0 : _a.destroy();\n            this.mCanvas.width \x3D el.offsetWidth;\n            this.mCanvas.height \x3D el.offsetHeight;\n            const ctx \x3D this.mCanvas.getContext(\"2d\");\n            this.mChartInstance \x3D new Chart(ctx\x2C {\n                type: this.mChartType\x2C\n                data: { labels: this.mLabels\x2C datasets: this.mDatasets }\x2C\n                options: this.mOptions\x2C\n                plugins: []\x2C\n            });\n            this.applyTooltip(el);\n            this.applyUserStyle(el);\n        }\n    }\n    ChartJS.ChartJSControl \x3D ChartJSControl;\n})(ChartJS || (ChartJS \x3D {}));\n", Scope = Public
	#tag EndConstant


	#tag Enum, Name = ChartTypes, Type = Integer, Flags = &h0
		Mixed
		  Area
		  Bar
		  Bubble
		  Doughnut
		  Line
		  PolarArea
		  Radar
		Scatter
	#tag EndEnum


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
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="34"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
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
			Name="LockBottom"
			Visible=true
			Group="Position"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockHorizontal"
			Visible=true
			Group="Position"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockLeft"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockRight"
			Visible=true
			Group="Position"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockTop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockVertical"
			Visible=true
			Group="Position"
			InitialValue="False"
			Type="Boolean"
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
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
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
			Name="TabIndex"
			Visible=true
			Group="Visual Controls"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Visible"
			Visible=true
			Group="Visual Controls"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Indicator"
			Visible=true
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
			Name="ChartType"
			Visible=false
			Group="Behavior"
			InitialValue="line"
			Type="ChartTypes"
			EditorType="Enum"
			#tag EnumValues
				"0 - Mixed"
				"1 - Area"
				"2 - Bar"
				"3 - Bubble"
				"4 - Doughnut"
				"5 - Line"
				"6 - PolarArea"
				"7 - Radar"
				"8 - Scatter"
			#tag EndEnumValues
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
