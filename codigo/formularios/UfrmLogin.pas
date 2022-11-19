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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.dfm}

end.
