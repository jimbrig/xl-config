Attribute VB_Name = "Main"
Option Explicit
Private Sub Workbook_Open()

    Application.OnKey "{F1}", ""
    ActiveWindow.Close
    
End Sub
Sub centerOverColumn()
Attribute centerOverColumn.VB_ProcData.VB_Invoke_Func = "J\n14"

    Selection.HorizontalAlignment = xlCenterAcrossSelection

End Sub
Sub generalAlignment()
Attribute generalAlignment.VB_ProcData.VB_Invoke_Func = "K\n14"

    Selection.HorizontalAlignment = xlGeneral

End Sub
Sub snapShot()
Attribute snapShot.VB_ProcData.VB_Invoke_Func = "S\n14"
'
' setupChecks Macro
' Adds rows and columns up and pastes values, then checks to see if anything has changed after modification. Used for tech review purposes.

    Application.Calculation = xlCalculationManual

    'Sets a cell equal to everything in print range
    Range("Xba2").Select
    ActiveCell.FormulaR1C1 = "=RC[-16276]"
    Range("Xba2").Copy
    
    Range("Xba2:XFD1000").Select
    ActiveSheet.Paste
    ActiveSheet.Calculate
    Selection.Copy
    
    'Pastes values of everything in print range and checks to see if two are equivalent.
    Range("Xba1002").Select
    Selection.PasteSpecial Paste:=xlPasteValues
        
    Range("Xba2002").Select
    ActiveCell.FormulaR1C1 = "=R[-1000]C=R[-2000]C"
    Range("Xba2002").Copy
    Range("Xba2002:Xfd3000").Select
    ActiveSheet.Paste
    
    
    'Counts the number of true and false values and checks to see if these change.
    
    Range("xk1").Select
    ActiveCell.FormulaR1C1 = "=COUNTIF(R[1]:R[99999],TRUE)"
    ActiveSheet.Calculate
    Selection.Copy
    
    Range("xm1").Select
    Selection.PasteSpecial Paste:=xlPasteValues

    Range("xl1").Select
    ActiveCell.FormulaR1C1 = "=COUNTIF(R[1]:R[99999],FALSE)"
    Calculate
    Selection.Copy
    
    Range("xn1").Select
    Selection.PasteSpecial Paste:=xlPasteValues
    
    Range("F1").Select
    ActiveCell.FormulaR1C1 = "=AND(RC[629]=RC[631],RC[630]=RC[632])"
    Range("R1").Select
    ActiveCell.FormulaR1C1 = "=RC[-12]"
    Range("ad1").Select
    ActiveCell.FormulaR1C1 = "=RC[-12]"
    Range("ap1").Select
    ActiveCell.FormulaR1C1 = "=RC[-12]"
    Range("bb1").Select
    ActiveCell.FormulaR1C1 = "=RC[-12]"
   
    
    'Makes the cell easier to read
    Range("f1,r1,ad1,ap1,bb1").Select
    Selection.Font.Size = 20
    Selection.Font.Color = -16776961
    Selection.Interior.Color = 65535
    Selection.Font.Bold = True
    Selection.Columns.AutoFit
    Selection.Rows.AutoFit
    
    Range("a1").Select
    
    Application.Calculation = xlCalculationAutomatic

End Sub
Sub snapShotReset()
Attribute snapShotReset.VB_ProcData.VB_Invoke_Func = "Z\n14"

    'Should only be used after snapShot sub has been used.
    'This is used to re-paste the values off the the side so that check is back to true.

    Range("Xba2:XFD1000").Copy
    Range("Xba1002").PasteSpecial Paste:=xlPasteValues
    
    'Puts the active cell back to the beginning of sheet
    Range("A1").Select

End Sub
Sub RefreshZoom()
Attribute RefreshZoom.VB_ProcData.VB_Invoke_Func = "A\n14"

    Dim ws As Worksheet
    Dim targetZoom As Integer

        targetZoom = InputBox(Prompt:="Target Zoom:", _
            Title:="Target Zoom", Default:="Enter Desired Zoom")
            
    Application.Calculation = xlCalculationManual
            
    For Each ws In Worksheets
           
        If ws.Visible = xlSheetHidden Or ws.Visible = xlVeryHidden Then GoTo Line2
           
            ws.Select
            ActiveWindow.View = xlNormalView
            ActiveWindow.Zoom = targetZoom
            ws.Range("a1").Activate
               
Line2:    Next ws

    ActiveWorkbook.Worksheets(1).Activate
    Application.Calculation = xlCalculationAutomatic

End Sub
Sub FitComments()
Attribute FitComments.VB_ProcData.VB_Invoke_Func = "V\n14"


Dim xComment As Comment

    For Each xComment In Application.ActiveSheet.Comments
        xComment.Shape.TextFrame.AutoSize = True
    Next
    
End Sub
Sub blackAndWhite()

Dim sheet As Worksheet

For Each sheet In Worksheets

sheet.PageSetup.blackAndWhite = True

Next sheet

End Sub
Sub autoFitColumns()
Attribute autoFitColumns.VB_ProcData.VB_Invoke_Func = "C\n14"

    Selection.Columns.AutoFit
    
End Sub
Sub BlueFont()
Attribute BlueFont.VB_ProcData.VB_Invoke_Func = "B\n14"
    With Selection.Font
        .Color = -65536
        .TintAndShade = 0
    End With
End Sub
Sub RedFont()
Attribute RedFont.VB_ProcData.VB_Invoke_Func = "E\n14"
    With Selection.Font
        .Color = -16776961
        .TintAndShade = 0
    End With
End Sub
Sub PinkFont()
Attribute PinkFont.VB_ProcData.VB_Invoke_Func = "P\n14"
    With Selection.Font
        .Color = -65281
        .TintAndShade = 0
    End With
End Sub
Sub NumberFormat()
Attribute NumberFormat.VB_ProcData.VB_Invoke_Func = "N\n14"
    With Selection
        .NumberFormat = "#,##0_);[Red](#,##0)"
    End With
End Sub
Sub DollarFormat()
Attribute DollarFormat.VB_ProcData.VB_Invoke_Func = "D\n14"
    With Selection
        .NumberFormat = "$#,##0_);[Red]($#,##0)"
    End With
End Sub
Sub FDXChgLinks()

Dim cell As Range
Dim rng As Range
Dim old_link As String
Dim new_link As String
Dim wb As Workbook
Dim linkwb As Workbook

'Application.AskToUpdateLinks = False

Set wb = ActiveWorkbook
Set rng = Range("links_rng")

For Each cell In rng

If cell.Value = "UPDATED" Then GoTo Line2

old_link = cell.Offset(, 2).Text
new_link = cell.Offset(, 3).Text

On Error GoTo Line2

Workbooks.Open Filename:=new_link, UpdateLinks:=False

wb.Activate

ActiveWorkbook.ChangeLink Name:=old_link, NewName:=new_link, Type:=xlExcelLinks

cell.Value = "UPDATED"

Set linkwb = Workbooks.Open(new_link)
With linkwb
    .Close SaveChanges:=False
End With
Set linkwb = Nothing

'linkwb.Activate
'ActiveWorkbook.Close SaveChanges:=False
'Application.ActiveWindow.Close SaveChanges:=False
'Application.Quit

'Windows(new_link).Activate
'ActiveWorkbook.Close SaveChanges:=False

wb.Activate

Line2: Next cell

End Sub

Sub Comments()

Dim cel As Range
Dim com As String
Dim selRng As Range

Set selRng = Application.Selection

 For Each cell In selRng.Cells
 
 With cell
    .ClearComments
 End With
 
 If cell.Value <> "" Then
 
 With cell.AddComment(cell.Text)
    With .Shape.TextFrame
        With .Characters(1, 13).Font
            .Bold = True
        End With
    End With
End With

End If

Next

Call FitComments

End Sub

Sub SetGlobalPrintArea()

Dim xWs As Worksheet
Dim WorkRng As Range
Set WorkRng = Application.Selection
For Each xWs In Application.ActiveWindow.SelectedSheets
    xWs.PageSetup.PrintArea = WorkRng.Address
Next
End Sub

Sub ShowAllNames()
Dim n As Name
For Each n In ActiveWorkbook.Names
n.Visible = True
Next n
End Sub

Sub GoToSheets()
Attribute GoToSheets.VB_ProcData.VB_Invoke_Func = "G\n14"

    Application.CommandBars("workbook tabs").ShowPopup

End Sub

Sub FormatData()

' Keyboard Shortcut:

Dim ws As Worksheet
Dim rng As Range
Dim numSheets As Integer

numSheets = ActiveWorkbook.Worksheets.Count

For Each ws In Worksheets
     If ws.CodeName = "Sheet" & numSheets Then GoTo Line1
            ws.Select
            Columns("X:IV").Clear
            If ActiveSheet.AutoFilterMode Then Cells.AutoFilter
            Cells.Select
            Selection.NumberFormat = "General"
            

Set rng = Range(Range("B2:Z2").Find("DOI").Offset(1), Range("B2:Z2").Find("DOI").Offset(1).End(xlDown))

rng.NumberFormat = "m/d/yyyy"
        
Set rng = Range(Range("B2:Z2").Find("Added Date").Offset(1), Range("B2:Z2").Find("Added Date").Offset(1).End(xlDown))

rng.NumberFormat = "m/d/yyyy"
        
Set rng = Range(Range("B2:Z2").Find("Last Status Date").Offset(1), Range("B2:Z2").Find("Last Status Date").Offset(1).End(xlDown))

rng.NumberFormat = "m/d/yyyy"

Set rng = Range(Range("B2:Z2").Find("Indemnity Paid").Offset(1), Range("B2:Z2").Find("Indemnity Outstanding").Offset(1).End(xlDown))

rng.NumberFormat = "#,##0_);[Red](#,##0)"

Set rng = Range(Range("B2:Z2").Find("Medical Incurred").Offset(1), Range("B2:Z2").Find("Total Incurred").Offset(1).End(xlDown))

rng.NumberFormat = "#,##0_);[Red](#,##0)"

Set rng = Range(Range("B2:Z2").Find("GM").Offset(1), Range("B2:Z2").Find("GM").Offset(1).End(xlDown))

rng.NumberFormat = "#,##0_);[Red](#,##0)"
        
Columns("X:IV").Select
Selection.Clear
           
Range("A1").Select
    
Line1: Next ws


End Sub




    
