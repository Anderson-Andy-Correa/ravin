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

  // Nome não pode ser vazio
  // Login não pode ser vazio
  // CPF não pode ser vazio
  // Quantidade de caracter do login
  // Só número no CPF
  // Nome não pode aceitar número
  // Validar caracteres especiais
  // CPF não pode ser vazio
  // Senha = Confirmação Senha
  // CPF é Válido

  if PUsuario.Login.IsEmpty then
    raise Exception.Create('O campo login não pode ser vazio.');

  if PUsuario.senha.IsEmpty then
    raise Exception.Create('O campo senha não pode ser vazio.');

  if PUsuario.senha <> PSenhaConfirmacao then
    raise Exception.Create('A senha e a confirmação devem ser iguais.');
  end;

end.
