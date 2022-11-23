unit ValidadorUsuario;

interface

Uses
  Uusuario, System.SysUtils;

Type
  TValidadorUsuario = class
    private

    protected

    public
    class procedure Validar(PUsuario: TUsuario; PSenhaConfirmacao: String);
  end;

implementation

{ TValidadorUsuario }

class procedure TValidadorUsuario.Validar(PUsuario: TUsuario; PSenhaConfirmacao: String);
  begin

  // Nome n�o pode ser vazio
  // Login n�o pode ser vazio
  // CPF n�o pode ser vazio
  // Quantidade de caracter do login
  // S� n�mero no CPF
  // Nome n�o pode aceitar n�mero
  // Validar caracteres especiais
  // CPF n�o pode ser vazio
  // Senha = Confirma��o Senha
  // CPF � V�lido

  if PUsuario.Login.IsEmpty then
    raise Exception.Create('O campo login n�o pode ser vazio.');

  if PUsuario.senha.IsEmpty then
    raise Exception.Create('O campo senha n�o pode ser vazio.');

  if PUsuario.senha <> PSenhaConfirmacao then
    raise Exception.Create('A senha e a confirma��o devem ser iguais.');
  end;

end.
