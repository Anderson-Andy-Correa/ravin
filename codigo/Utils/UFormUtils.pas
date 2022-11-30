unit UFormUtils;

interface

uses
  Vcl.Forms, System.Classes;

Type
  TFormUtils = class
    private

    protected

    public
      class procedure SetMainForm(PNewMainForm:Tform);
//      class procedure OpenNewForm(PTypeNewForm: TComponentClass;
//                                       PNewForm: TForm;
//                                       POldForm: TForm;
//                                       Change: Boolean = True);
      class procedure ChangeOpenedForm(PTypeNewForm: TComponentClass;
                                       PNewForm: TForm); overload;
      class procedure ChangeOpenedForm(PTypeNewForm: TComponentClass;
                                       PNewForm: TForm;
                                       PTypeOldForm: TCustomForm); overload;
  end;

implementation

{ TFormUtils }

class procedure TFormUtils.ChangeOpenedForm(PTypeNewForm: TComponentClass;
                  PNewForm: TForm; PTypeOldForm: TCustomForm);
  begin
    if not Assigned(PNewForm) then
      begin
        Application.CreateForm(PTypeNewForm, PNewForm);
      end;

    TFormUtils.SetMainForm(PNewForm);
    PNewForm.Show();

    PTypeOldForm.Close;
  end;

class procedure TFormUtils.ChangeOpenedForm(PTypeNewForm: TComponentClass;
  PNewForm: TForm);
begin
    if not Assigned(PNewForm) then
      begin
        Application.CreateForm(PTypeNewForm, PNewForm);
      end;

    PNewForm.Show();
  end;

//class procedure TFormUtils.OpenNewForm(PTypeNewForm: TComponentClass;
//  PNewForm, POldForm: TForm; Change: Boolean = True);
//  begin
//    if not Assigned(PNewForm) then
//      begin
//        Application.CreateForm(PTypeNewForm, PNewForm);
//      end;
//
//    if change then TFormUtils.SetMainForm(PNewForm);
//    PNewForm.Show();
//
//    if change then POldForm.Close;
//  end;

class procedure TFormUtils.SetMainForm(PNewMainForm: Tform);
  var
    tmpMain: ^TCustomForm;
  begin
    tmpMain := @Application.Mainform;
    tmpMain^ := PNewMainForm;
  end;

end.
