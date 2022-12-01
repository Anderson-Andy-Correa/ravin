unit UfrmListaClientes;

interface

uses
  Winapi.Windows,
  Winapi.Messages,

  System.SysUtils,
  System.Variants,
  System.Classes,

  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ComCtrls,
  Vcl.StdCtrls,

  UfrmBotaoPrimario,
  UfrmBotaoCancelar, Vcl.ExtCtrls;

type
  TfrmListaClientes = class(TForm)
    frmBotaoPrimario: TfrmBotaoPrimario;
    frmBotaoCancelar: TfrmBotaoCancelar;
    lvwClientes: TListView;
    Shape1: TShape;
    Shape2: TShape;
    Shape5: TShape;
    lblInformacoesGerenciais: TLabel;
    pnlListaClientes: TPanel;
    lblListaClientesTitulo: TLabel;
    procedure frmBotaoPrimariospbBotaoPrimarioClick(Sender: TObject);
    procedure frmBotaoCancelarspbBotaoCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmListaClientes: TfrmListaClientes;

implementation

{$R *.dfm}

uses UfrmCadastroCliente;

procedure TfrmListaClientes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(frmListaClientes);
end;

procedure TfrmListaClientes.frmBotaoCancelarspbBotaoCancelarClick(
  Sender: TObject);
begin
  close;
end;

procedure TfrmListaClientes.frmBotaoPrimariospbBotaoPrimarioClick
  (Sender: TObject);
//var
//  LItem: TListItem;
begin
  if (not Assigned(frmCadastroCliente)) then
    begin
      Application.CreateForm(TfrmCadastroCliente, frmCadastroCliente);
    end;
    frmCadastroCliente.frmBotaoExcluir.Visible := False;
    frmCadastroCliente.lblCadastroCliente.Caption := 'Cadastrar novo Cliente';
    frmCadastroCliente.show();

//  LItem := lvwClientes.Items.Add();
//  LItem.Caption := 'Marcio';
//  LItem.SubItems.Add('2134234324');
//  LItem.SubItems.Add('(47)9925645663');
//  LItem.SubItems.Add('Ativo');
end;

end.
