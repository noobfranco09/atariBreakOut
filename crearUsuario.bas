B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=13
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: True
	#IncludeTitle: False
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	Dim sql As SQL
	Dim dt As Cursor
	
End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.

	Private txtContraseña As EditText
	Private txtUsuario As EditText
End Sub

Sub Activity_Create(FirstTime As Boolean)
	'Do not forget to load the layout file created with the visual designer. For example:
	Activity.LoadLayout("registrarse")
	
	If File.Exists(File.DirInternal, "usuarios2.db3") = False Then
		File.Copy(File.DirAssets, "usuarios2.db3", File.DirInternal, "usuarios2.db3")
		Log("Base de datos creada")
	End If	
	
	If sql.IsInitialized = False Then
		sql.Initialize(File.DirInternal, "usuarios2.db3", False)
		Log("Objeto sql inicializado")
	End If
	


End Sub

Sub Activity_Resume

End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub


Private Sub btnGuardar_Click
	Dim username As String = txtUsuario.Text
	Dim pass As String = txtContraseña.Text
	
	If username.Trim = "" Or pass.Trim = "" Then
		ToastMessageShow("Ingrese los campos", False)
		Return
	End If
	
	Try
		Dim verificacion As String = "select * from usuarios where usuario = ?"
		dt = sql.ExecQuery2(verificacion, Array As String(username))
		
		If dt.RowCount > 0 Then
			ToastMessageShow("El usuario ya fue creado", False)
			Return
		End If
	Catch
		Log(LastException)
	End Try
	
	
	
	Try
		Dim consulta As String = "insert into usuarios(usuario, password, puntaje) values (?, ?, ?)"
		
		sql.ExecNonQuery2(consulta, Array As Object(username, pass, 0))
		ToastMessageShow("Usuario ingresado con exito", False)
		
		Activity.Finish
	Catch
		ToastMessageShow("Error al crear el usuario", False)
		Log(LastException)
	End Try
End Sub

Private Sub btnCancelar_Click
	Activity.Finish
End Sub