unit UfrmLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls, UfrmAutenticar;

type
  TfrmLogin = class(TForm)
    pnlAutentificacao: TPanel;
    edtLogin: TEdit;
    imgFundo: TImage;
    imgLogo: TImage;
    edtSenha: TEdit;
    lblTitulo: TLabel;
    lblSubTitulo: TLabel;
    lblTituloRegistrar: TLabel;
    lblSubTituloRegistrar: TLabel;
    frmAutenticar1: TfrmAutenticar;
    procedure frmAutenticar1spdAutenticarClick(Sender: TObject);
    procedure lblSubTituloRegistrarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SetarFormPrincipal(PNovoFormulario: TForm);
  end;

var
  frmLogin: TfrmLogin;

implementation

uses
  UfrmPainelGestao, UusuarioDao, Uusuario, UfrmRegistrar, UiniUtils;

{$R *.dfm}

procedure TfrmLogin.frmAutenticar1spdAutenticarClick(Sender: TObject);
  var
    LDao: TUsuarioDAO;
    LUsuario: TUsuario;
    LLogin: String;
    LSenha: String;
  begin
    LDao := TUsuarioDAO.Create;

    LLogin := edtLogin.Text;
    LSenha := edtSenha.Text;

    LUsuario := LDao.BuscarUsuarioPorLoginSenha(LLogin, LSenha);

    if Assigned(LUsuario) then
      begin
        TIniUtils.gravarPropriedade(TSecao.INFORMACOES_GERAIS, TPROPRIEDADE.LOGADO, TIniUtils.VALOR_VERDADEIRO);
        if not assigned(frmPainelGestao) then
          begin
            application.CreateForm(TfrmPainelGestao, frmPainelGestao);
          end;

         SetarFormPrincipal(frmPainelGestao);
         frmPainelGestao.Show;

         Close();
      end
    else
      begin
        ShowMessage('Login e/ou senha inválidos!');
      end;

    FreeAndNil(LUsuario);
    FreeAndNil(LDAo);
  end;

procedure TfrmLogin.lblSubTituloRegistrarClick(Sender: TObject);
  begin
    if not Assigned(frmRegistrar) then
    begin
      Application.CreateForm(TfrmRegistrar, frmRegistrar);
    end;

    SetarFormPrincipal(frmRegistrar);
    frmRegistrar.Show();

    Close();
  end;

procedure TfrmLogin.SetarFormPrincipal(PNovoFormulario: TForm);
  var
    tmpMain: ^TCustomForm;
  begin
    tmpMain := @Application.Mainform;
    tmpMain^ := PNovoFormulario;
  end;

end.
